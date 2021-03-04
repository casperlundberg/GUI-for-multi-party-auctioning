/*
========================
Template
========================
*/
String name = '''''';
String get() {
  return name;
}

void set(String newString) {
  name = newString;
}

/*
========================
USERLIST
========================
*/
String userListString = '''{
    "users": [
        {
            "userId": 1,
            "userName": "Thule Thulesson",
            "email": "thule@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "d61525efc3eb135288f6be621fcd7e8a6f1c6f336dab46fac2f7faf9bbb94d6c"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-98",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Consumer",
            "company": "Teknologkåren",
            "participatingAuctions": [
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 3
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                }
            ]
        },
        {
            "userId": 2,
            "userName": "casper",
            "email": "casper@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "d61525efc3eb135288f6be621fcd7e8a6f1c6f336dab46fac2f7faf9bbb94d6c"
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
            "currentType": "Consumer",
            "company": "Netlight",
            "participatingAuctions": [
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 3
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                }
            ]
        },
        {
            "userId": 3,
            "userName": "Elliot Huber",
            "email": "elliot@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "d61525efc3eb135288f6be621fcd7e8a6f1c6f336dab46fac2f7faf9bbb94d6c"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-234",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Consumer",
            "company": "Teknologkåren",
            "participatingAuctions": [
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 3
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                }
            ]
        },
        {
            "userId": 4,
            "userName": "Erik Salomonsson",
            "email": "erik@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "d61525efc3eb135288f6be621fcd7e8a6f1c6f336dab46fac2f7faf9bbb94d6c"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-1",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Supplier",
            "company": "Teknologkåren",
            "participatingAuctions": [
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 3
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                }
            ]
        },
        {
            "userId": 5,
            "userName": "g",
            "email": "gustav@gmail.com",
            "password": {
                "type": "sha1",
                "encryption": "d61525efc3eb135288f6be621fcd7e8a6f1c6f336dab46fac2f7faf9bbb94d6c"
            },
            "age": 35,
            "address": {
                "streetAddress": "Tekniktorget 3",
                "city": "Luleå",
                "state": "Norrbotten",
                "postalCode": "971 83"
            },
            "homePhoneNumber": "212 555-1234",
            "mobilePhoneNumber": "212 555-3",
            "officePhoneNumber": "212 555-1234",
            "currentType": "Consumer",
            "company": "Teknologkåren",
            "participatingAuctions": [
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 3
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                }
            ]
        }
    ]
}''';
String getUserListString() {
  return userListString;
}

void setUserListString(String newString) {
  userListString = newString;
}

/*
========================
AUCTIONDETAILS
========================
*/
String auctionDetailsListString = '''{
    "auctionDetailsList": [
        {
            "id": 1,
            "title": "Testauction 1",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:01:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:03:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-02-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 2,
            "title": "Testauction 2",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Stone",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:04:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:05:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-02-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 3,
            "title": "Testauction 3",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Gold",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:03:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:05:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 4,
            "title": "Testauction 4",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Silver",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:04:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:11:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 5,
            "title": "Testauction 5",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:01:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:03:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 6,
            "title": "Testauction 6",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:06:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:07:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 7,
            "title": "Testauction 7",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T11:20:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:00:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 8,
            "title": "Testauction 8",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 2
                },
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T10:51:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:01:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 9,
            "title": "Testauction 9",
            "ownerID": 2,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "participants": [
                {
                    "userID": 3
                },
                {
                    "userID": 4
                },
                {
                    "userID": 5
                }
            ],
            "roundTime": 300,
            "material": "Wood",
            "contractTemplateID": 1,
            "bids": [
                {
                    "userID": 2,
                    "time" : "2021-02-15T10:44:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Thule Thulesson"
                        },
                        {
                            "key": "Quantity",
                            "value": 5
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 25
                        },
                        {
                            "key": "Amount of hours",
                            "value": 10
                        }
                    ]
                },
                {
                    "userID": 3,
                    "time" : "2021-02-15T11:29:00+01:00",
                    "keyValuePairs": [
                        {
                            "key": "Name",
                            "value": "Sven Svensson"
                        },
                        {
                            "key": "Quantity",
                            "value": 1
                        },
                        {
                            "key": "ArticleID",
                            "value": 726387327
                        },
                        {
                            "key": "Amount of money",
                            "value": 55
                        },
                        {
                            "key": "Amount of hours",
                            "value": 2
                        }
                    ]
                }
            ],
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        }
    ]
}''';
String getAuctionDetailsListString() {
  return auctionDetailsListString;
}

void setAuctionDetailsListString(String newString) {
  auctionDetailsListString = newString;
}

/*
========================
AUCTIONLIST
========================
*/
String auctionsListString = '''{
    "auctionList": [
        {
            "id": 1,
            "title": "Testauction 1",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-02-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 2,
            "title": "Testauction 2",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Stone",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-02-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 3,
            "title": "Testauction 3",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Gold",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 4,
            "title": "Testauction 4",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Silver",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 5,
            "title": "Testauction 5",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 6,
            "title": "Testauction 6",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 7,
            "title": "Testauction 7",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 8,
            "title": "Testauction 8",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        },
        {
            "id": 9,
            "title": "Testauction 9",
            "ownerID": 1,
            "ownerType" : "Supplier",
            "maxParticipants": 10,
            "currentParticipants": 0,
            "roundTime": 300,
            "material": "Wood",
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material"
        }
    ]
}''';
String getAuctionsListString() {
  return auctionsListString;
}

void setAuctionsListString(String newString) {
  auctionsListString = newString;
}

/*
========================
FILTERLIST
========================
*/
String filterListString = '''{
    "filters": [
        {
            "id": 1,
            "name": "Wood",
            "description": "Soft material which often is used in the paper industry"
        },
        {
            "id": 2,
            "name": "Metals",
            "description": "Metal is stronger than most materials"
        },
        {
            "id": 3,
            "name": "Soil",
            "description": "Soil is used to grow plants and trees"
        },
        {
            "id": 4,
            "name": "Stone",
            "description": "Description for stone"
        },
        {
            "id": 5,
            "name": "Gold",
            "description": "Description for gold"
        },
        {
            "id": 6,
            "name": "Silver",
            "description": "Description for silver"
        }
    ]
}''';
String getFilterListString() {
  return filterListString;
}

void setFilterListString(String newString) {
  filterListString = newString;
}

/*
========================
Template
========================
*/
String supplierContractTemplatesString = '''{
    "contractTemplates": [
        {
            "id": 1,
            "templateStrings": [
                {
                    "text": "I, "
                },
                {
                    "text": " hereby makes an order for "
                },
                {
                    "text": " units of "
                },
                {
                    "text": " at the unit price of "
                },
                {
                    "text": " EUR from Component Supplier Inc. The units are to be delivered by Carrier Inc. to the Final Assembly Plant in "
                },
                {
                    "text": " hours."
                }
            ],
            "templateVariables": [
                {
                    "key": "Name",
                    "valueType": "Text"
                },
                {
                    "key": "Quantity",
                    "valueType": "Integer"
                },
                {
                    "key": "ArticleID",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of hours",
                    "valueType": "Integer"
                }
            ]
        },
        {
            "id": 2,
            "templateStrings": [
                {
                    "text": "I, "
                },
                {
                    "text": " would like to purchase a unit of "
                },
                {
                    "text": " at the price of "
                },
                {
                    "text": " EUR from Component Supplier Inc. The units are to be delivered by Carrier Inc. to the Final Assembly Plant in "
                },
                {
                    "text": " hours."
                }
            ],
            "templateVariables": [
                {
                    "key": "Name",
                    "valueType": "Text"
                },
                {
                    "key": "ArticleID",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of hours",
                    "valueType": "Integer"
                }
            ]
        },
        {
            "id": 3,
            "templateStrings": [
                {
                    "text": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
                },
                {
                    "text": " would like to purchase a unit of "
                },
                {
                    "text": " at the price of "
                },
                {
                    "text": " EUR from Component Supplier Inc. The units are to be delivered by Carrier Inc. to the Final Assembly Plant in "
                },
                {
                    "text": "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
                }
            ],
            "templateVariables": [
                {
                    "key": "Name",
                    "valueType": "Text"
                },
                {
                    "key": "ArticleID",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of hours",
                    "valueType": "Integer"
                }
            ]
        }
    ]
}''';
String getSupplierContractTemplatesString() {
  return supplierContractTemplatesString;
}

void setSupplierContractTemplatesString(String newString) {
  supplierContractTemplatesString = newString;
}

/*
========================
Template
========================
*/
String consumerContractTemplatesString = '''{
    "contractTemplates": [
        {
            "id": 1,
            "templateStrings": [
                {
                    "text": ""
                },
                {
                    "text": " hereby makes an offer of "
                },
                {
                    "text": " units of "
                },
                {
                    "text": " at the unit price of "
                },
                {
                    "text": " EUR from Component Supplier Inc. The units are to be delivered by Carrier Inc. to the Final Assembly Plant in "
                },
                {
                    "text": " hours."
                }
            ],
            "templateVariables": [
                {
                    "key": "CompanyName",
                    "valueType": "Text"
                },
                {
                    "key": "Quantity",
                    "valueType": "Integer"
                },
                {
                    "key": "ArticleID",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of hours",
                    "valueType": "Integer"
                }
            ]
        },
        {
            "id": 2,
            "templateStrings": [
                {
                    "text": ""
                },
                {
                    "text": " would like to sell a unit of "
                },
                {
                    "text": " at the price of "
                },
                {
                    "text": " EUR from Component Supplier Inc. The units are to be delivered by Carrier Inc. to the Final Assembly Plant in "
                },
                {
                    "text": " hours."
                }
            ],
            "templateVariables": [
                {
                    "key": "CompanyName",
                    "valueType": "Text"
                },
                {
                    "key": "ArticleID",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of hours",
                    "valueType": "Integer"
                }
            ]
        }
    ]
}''';
String getConsumerContractTemplatesString() {
  return consumerContractTemplatesString;
}

void setConsumerContractTemplatesString(String newString) {
  consumerContractTemplatesString = newString;
}
