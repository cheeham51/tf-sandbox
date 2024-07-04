resource "aws_ssm_document" "pause_grafana_alert_ssm_doc" {
  name            = "FF-PAUSE-GRAFANA-ALERTS"
  document_format = "YAML"
  document_type   = "Automation"

  content = <<DOC
description: |-
schemaVersion: '0.3'
assumeRole: 'arn:aws:iam::516161102907:role/test-test'
mainSteps:
  - name: pauseGrafanaAlert
    action: 'aws:executeScript'
    inputs:
      Runtime: python3.8
      Handler: script_handler
      Script: |-
        import boto3
        import urllib.request
        import json
        from botocore.exceptions import ClientError

        def script_handler(events, context):
          secret_name = "dev/grafana/key"
          # Create a Secrets Manager client
          session = boto3.session.Session()
          client = session.client(
            service_name='secretsmanager',
          )

          try:
              get_secret_value_response = client.get_secret_value(
                SecretId=secret_name
              )
          except ClientError as e:
              raise e

          api_key = get_secret_value_response['SecretString']

          url = "https://g-d0437246cb.grafana-workspace.ap-southeast-2.amazonaws.com/api/v1/provisioning/alert-rules/wocUT79Vz"

          headers = {
              'Authorization': f'Bearer {api_key}',
              'Content-Type': 'application/json'
          }

          # create a request object
          req = urllib.request.Request(url, headers=headers)

          # make API request for alert rule
          with urllib.request.urlopen(req) as response:
              data = json.loads(response.read())
          
          # update the "isPaused" field to True
          data['isPaused'] = True

          # create a new request for the PUT request
          req = urllib.request.Request(url, data=json.dumps(data).encode(), headers=headers, method='PUT')

          # make the PUT request to update the data
          with urllib.request.urlopen(req) as response:
              result = json.loads(response.read())

          print(result)
  - name: sleep
    action: aws:sleep
    inputs:
      Duration: P1D
  - name: resumeGrafanaAlert
    action: 'aws:executeScript'
    inputs:
      Runtime: python3.8
      Handler: script_handler
      Script: |-
        import boto3
        import urllib.request
        import json
        from botocore.exceptions import ClientError

        def script_handler(events, context):
          secret_name = "dev/grafana/key"
          # Create a Secrets Manager client
          session = boto3.session.Session()
          client = session.client(
            service_name='secretsmanager',
          )

          try:
              get_secret_value_response = client.get_secret_value(
                SecretId=secret_name
              )
          except ClientError as e:
              raise e

          api_key = get_secret_value_response['SecretString']

          url = "https://g-d0437246cb.grafana-workspace.ap-southeast-2.amazonaws.com/api/v1/provisioning/alert-rules/wocUT79Vz"

          headers = {
              'Authorization': f'Bearer {api_key}',
              'Content-Type': 'application/json'
          }

          # create a request object
          req = urllib.request.Request(url, headers=headers)

          # make API request for alert rule
          with urllib.request.urlopen(req) as response:
              data = json.loads(response.read())
          
          # update the "isPaused" field to True
          data['isPaused'] = False

          # create a new request for the PUT request
          req = urllib.request.Request(url, data=json.dumps(data).encode(), headers=headers, method='PUT')

          # make the PUT request to update the data
          with urllib.request.urlopen(req) as response:
              result = json.loads(response.read())

          print(result)
DOC
}