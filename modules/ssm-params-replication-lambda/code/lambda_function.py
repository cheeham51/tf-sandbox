import boto3
import logging
import os
from botocore.exceptions import ClientError

log_level = os.environ["LOG_LEVEL"]
source_region = os.environ["REPLICATION_SOURCE_REGION"]
target_region = os.environ["REPLICATION_TARGET_REGION"]

logger = logging.getLogger(__name__)
logger.setLevel(log_level)

def replicate_ssm_parameter_with_tags(parameter_name, source_region, destination_region):
    # Create SSM clients for source and destination regions
    source_client = boto3.client('ssm', region_name=source_region)
    destination_client = boto3.client('ssm', region_name=target_region)

    try:
        # Get parameter from source region
        source_parameter = source_client.get_parameter(Name=parameter_name, WithDecryption=True)
        value = source_parameter['Parameter']['Value']
        param_type = source_parameter['Parameter']['Type']

        # Get tags from source parameter
        tag_response = source_client.list_tags_for_resource(
            ResourceType='Parameter',
            ResourceId=parameter_name
        )
        tags = tag_response['TagList']

        # Put parameter in destination region
        destination_client.put_parameter(
            Name=parameter_name,
            Value=value,
            Type=param_type,
            Overwrite=True
        )

        # Add tags to the parameter in the destination region
        if tags:
            destination_client.add_tags_to_resource(
                ResourceType='Parameter',
                ResourceId=parameter_name,
                Tags=tags
            )

        logger.info(f"Parameter '{parameter_name}' with tags replicated successfully to {destination_region}.")
    except ClientError as e:
        logger.error(f"An error occurred: {e}")

def lambda_handler(event, context):
    logger.info("Received event: " + str(event))
    # Extracting values
    param_arn = event["resources"][0]
    param_name = event["detail"]["name"]
    operation = event["detail"]["operation"]

    logger.info("Source parameter arn: " + param_arn)
    logger.info("Parameter name: " + param_name)
    logger.info("Event action: " + operation)

    replicate_ssm_parameter_with_tags(param_name, source_region, target_region)
