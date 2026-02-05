# import requests
#
# api_url = 'https://api.calorieninjas.com/v1/imagetextnutrition'
# api_key = 'IHPqWE+n83wvb4t2ZvbtQg==qv0MfGaV3ipiRzse'  # Replace with your actual API key
# headers = {'X-Api-Key': api_key}
#
# image_path = r"D:\archive\food-101\food-101\images\apple_pie\134.jpg"
#
# with open(image_path, 'rb') as image_file:
#     files = {'media': image_file}
#     response = requests.post(api_url, headers=headers, files=files)
#
# print(response.status_code)  # Check status code
# print(response.text)  # Check raw response
# print(response.json())  # Convert to JSON













# import requests
# query = r'D:\archive\food-101\food-101\images\apple_pie\134.jpg'
# api_url = 'https://api.api-ninjas.com/v1/nutrition?query={}'.format(query)
# response = requests.get(api_url, headers={'X-Api-Key': 'IHPqWE+n83wvb4t2ZvbtQg==qv0MfGaV3ipiRzse'})
# if response.status_code == requests.codes.ok:
#     print(response.text)
# else:
#     print("Error:", response.status_code, response.text)



import requests

# Corrected query to contain the food name instead of a file path
query = "apple pie"

# Correctly formatting the API URL
api_url = f'https://api.api-ninjas.com/v1/nutrition?query={query}'

# Sending the request with the proper API key
headers = {'X-Api-Key': 'IHPqWE+n83wvb4t2ZvbtQg==qv0MfGaV3ipiRzse'}
response = requests.get(api_url, headers=headers)

# Handling the response
if response.status_code == requests.codes.ok:
    print(response.json())  # Using `.json()` instead of `.text` for structured data
else:
    print("Error:", response.status_code, response.text)
