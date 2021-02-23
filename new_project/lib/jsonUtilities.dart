String userString = '''{
    "userId": 1,
    "userName": "Thule Thulesson",
    "email": "thule@gmail.com",
    "password": {
        "type": "sha1",
        "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
    },
    "age": 35,
    "address": {
        "streetAddress": "Tekniktorget 3",
        "city": "Luleå",
        "state": "Norrbotten",
        "postalCode": "971 83"
    },
    "homePhoneNumber": "212 555-1234",
    "mobilePhoneNumber": "212 555-1234",
    "officePhoneNumber": "212 555-1234",
    "currentType": "Demander"
}''';
String getUserString() {
  return userString;
}

void setUserString(String newString) {
  userString = newString;
}

String userListString = '''{
    "users": [
        {
            "userId": 1,
            "userName": "Thule Thulesson",
            "email": "thule@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Demander",
            "company": "Teknologkåren"
        },
        {
            "userId": 2,
            "userName": "Casper Lundberg",
            "email": "casper@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Demander",
            "company": "Netlight"
        },
        {
            "userId": 3,
            "userName": "Elliot Huber",
            "email": "elliot@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Demander",
            "company": "Teknologkåren"
        },
        {
            "userId": 4,
            "userName": "Erik Salomonsson",
            "email": "erik@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Supplier",
            "company": "Teknologkåren"
        },
        {
            "userId": 5,
            "userName": "Gustav Curan",
            "email": "gustav@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "7638417db6d59f3c431d3e1f261cc637155684cd"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Supplier",
            "company": "Teknologkåren"
        }
    ]
}''';
String getUserListString() {
  return userListString;
}

void setUserListString(String newString) {
  userListString = newString;
}
