import json
from filters.severity_filter import severity_filter

def lambda_handler(event, context):
    # print("Received event: " + json.dumps(event, indent=2))
    
    try:
        filtered_event = {
            "Records": []
        }
        if event["Records"]:
            filtered_records = severity_filter(event["Records"])
        filtered_event["Records"] = filtered_records
        print(filtered_event)
        if filtered_event["Records"]:
            print("call sns")
        else:
            print("We have no records to send to SNS after filtering.")
        # print(message_body["detail"]["findings"][0]["Severity"])
        # for finding in message_body["detail"]["findings"]:
        #     print(finding["Severity"])
        #     print(finding)
        # msg = severity_filter()
        # print(msg)
        # return {
        #     'statusCode': 200,
        #     'body': json.dumps(event_json_str)
        # }
    except Exception as e:
        print("Error occurred: ", e)
        return {
            'statusCode': 500,
            'body': json.dumps('Failed to forward Security Hub finding to SNS.')
        }
