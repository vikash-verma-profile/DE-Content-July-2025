import requests
import json
import xml.etree.ElementTree as ET

# Part A: Fetch from JSON API
json_url = "https://jsonplaceholder.typicode.com/posts"
response = requests.get(json_url)
data = response.json()[:20]  # First 20 records

filtered = [{"userId": post["userId"], "title": post["title"], "body": post["body"]} for post in data]

# Write to posts.json
with open("posts.json", "w") as f:
    json.dump(filtered, f, indent=2)

# Part B: XML to JSON
# Sample XML string (can be replaced with file read or URL)
sample_xml = """
<blog>
  <post>
    <title>Intro to Python</title>
    <author>Jane Doe</author>
    <pubDate>2023-07-01</pubDate>
  </post>
  <post>
    <title>Data Engineering 101</title>
    <author>John Smith</author>
    <pubDate>2023-07-02</pubDate>
  </post>
</blog>
"""

root = ET.fromstring(sample_xml)
posts = []

for post in root.findall('post'):
    item = {
        "title": post.findtext("title"),
        "author": post.findtext("author"),
        "pubDate": post.findtext("pubDate")
    }
    posts.append(item)

# Write to posts.xml.json
with open("posts.xml.json", "w") as f:
    json.dump(posts, f, indent=2)
