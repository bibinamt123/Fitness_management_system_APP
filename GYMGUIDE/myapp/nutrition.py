import requests

api_url = 'https://api.calorieninjas.com/v1/imagetextnutrition'
image_file_descriptor = open(r"D:\archive\food-101\food-101\images\apple_pie\134.jpg", 'rb')
files = {'media': image_file_descriptor}
r = requests.post(api_url, files=files)
print(r.json())
#
#
# import requests
#
# api_url = 'https://api.calorieninjas.com/v1/imagetextnutrition'
# api_key = 'https://api.api-ninjas.com/v1/nutrition'  # Replace with your actual API key
#
# headers = {'X-Api-Key': api_key}
# image_file_path = r"D:\archive\food-101\food-101\images\apple_pie\134.jpg"
#
# with open(image_file_path, 'rb') as image_file:
#     files = {'media': image_file}
#     response = requests.post(api_url, headers=headers, files=files)
#
# # Debugging: Print response content
# print("Response Status Code:", response.status_code)
# print("Response Content:", response.text)
#
# # Ensure response is valid JSON before calling .json()
# try:
#     data = response.json()
#     print(data)
# except requests.exceptions.JSONDecodeError:
#     print("Error: Response is not in JSON format.")
