import sys

from bs4 import BeautifulSoup
import requests
from cookies import cookies

events_url = "https://adventofcode.com/2020/events"

events_response = requests.get(events_url, cookies=cookies)

if events_response.status_code != 200:
    print("Error in sending request")
    sys.exit(1)

soup = BeautifulSoup(events_response.text, 'html.parser')

stars_dict = {}
for year in soup.main.find_all(class_="eventlist-event"):
    stars_dict[year.a.string] = 0 if year.span is None else int(year.span.string[:-1])

table_template = """
| Year | Progress | Total |
| ---  | ---      | ---   |
"""

for year, stars in stars_dict.items():
    table_template += f"| {year} | {'⭐'*stars} | {stars}/50 |\n"

print(table_template)