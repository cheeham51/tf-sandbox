import json
# INFORMATIONAL - 0
# LOW - 1
# MEDIUM - 40
# HIGH - 70
# CRITICAL - 90

severity_mapping = {
    "INFORMATIONAL": 0,
    "LOW": 1,
    "MEDIUM": 40,
    "HIGH": 70,
    "CRITICAL": 90 
}

min_severity = severity_mapping["HIGH"]

def severity_filter(records):
    filtered_records = []
    if records:
        for record in records:
            message_body = json.loads(record["body"])
            if message_body["detail"]["findings"][0]["Severity"]["Normalized"] >= min_severity:
                filtered_records.append(record)
    return filtered_records