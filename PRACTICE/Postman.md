# Get all departments

~~GET http://localhost:8080/api/v1/departments~~

GET http://questionnaires.localhost:80/api/v1/departments

###

# Get 5 departments with offset

GET http://questionnaires.localhost:80/api/v1/departments?skip=5&limit=5

###

# Get card types negative offset

GET http://questionnaires.localhost:80/api/v1/card-types?skip=-1&limit=1

###

# Get department by id (Бирюзовый)

GET http://questionnaires.localhost:80/api/v1/departments/5

###

# Create department

POST http://questionnaires.localhost:80/api/v1/departments HTTP/1.1
content-type: application/json

```
{
  "name": "Test department123",
  "idDepartmentsSystem": null,
  "address": "8F9619FF-7B16-D012-B45D-90C04FC064F9",
  "workTime": "Test worktime",
  "phone": "Test phone",
  "addressString": "Test address string"
}
```
###

# Update department

PUT http://questionnaires.localhost:80/api/v1/departments HTTP/1.1
content-type: application/json
```
{
  "name": "string",
  "workTime": "string",
  "phone": "string",
  "addressString": "string",
  "IdDepartment": 1
}
```
###

# Delete department

DELETE  http://questionnaires.localhost:80/api/v1/departments/149

###

# Insert questionnaire
POST http://questionnaires.localhost:80/api/v1/questionnaires HTTP/1.1
content-type: application/json
```
{
  "firstName": "First name",
  "middleName": "Middle name",
  "surname": "Surname",
  "birthday": "2032-04-23",
  "regAddress": "8F9619FF-7B16-D012-B45D-90C04FC064F9",
  "idDirStatus": 1,
  "createDate": "2032-04-23",
  "pinEq": "0000"
}
```
###

# Delete dirChannel (foregn key contraint violation)

DELETE  http://questionnaires.localhost/api/v1/dir-channels/1
