import json
import boto3
import os

# Initialize SNS client
sns_client = boto3.client('sns')

# The ARN of your SNS topic
sns_topic_arn = os.environ["SNS_TOPIC_ARN"]

def lambda_handler(event, context):
    print("Received Security Hub event: " + json.dumps(event, indent=2))
    
    try:
        # Convert the event to a JSON string
        event_json_str = json.dumps(event)
        
        # Publish the event to SNS
        response = sns_client.publish(
            TopicArn=sns_topic_arn,
            Message=event_json_str,
            Subject='Security Hub Finding',
            MessageStructure='string'
        )
        
        print("SNS Publish Response: " + json.dumps(response, indent=2))
        
        return {
            'statusCode': 200,
            'body': json.dumps('Successfully forwarded Security Hub finding to SNS.')
        }
    except Exception as e:
        print("Error occurred: ", e)
        return {
            'statusCode': 500,
            'body': json.dumps('Failed to forward Security Hub finding to SNS.')
        }
