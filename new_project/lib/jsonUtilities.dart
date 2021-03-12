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
USERS
========================
*/
String users = '''{
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
                    "auctionID": 1
                },
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
                },
                {
                    "auctionID": 6
                },
                {
                    "auctionID": 7
                },
                {
                    "auctionID": 10
                },
                {
                    "auctionID": 11
                },
                {
                    "auctionID": 12
                },
                {
                    "auctionID": 13
                }
            ],
            "offers": [
                {
                    "offerID": 3
                },
                {
                    "offerID": 4
                },
                {
                    "offerID": 5
                }
            ],
            "requestInbox": [
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "Pending",
                    "auctionID": 3,
                    "userID": 2
                },
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "Declined",
                    "auctionID": 9,
                    "userID": 2
                }
            ],
            "inviteInbox": [
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "Accepted",
                    "auctionID": 7,
                    "userID": 2,
                    "offerID": 2
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
                    "auctionID": 1
                },
                {
                    "auctionID": 2
                },
                {
                    "auctionID": 4
                },
                {
                    "auctionID": 5
                },
                {
                    "auctionID": 6
                },
                {
                    "auctionID": 7
                },
                {
                    "auctionID": 8
                },
                {
                    "auctionID": 9
                },
                {
                    "auctionID": 10
                }
            ],
            "offers":[
                {
                    "offerID": 1
                },
                {
                    "offerID": 2
                }
            ],
            "requestInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null
                }

            ],
            "inviteInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null,
                    "offerID": null
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
                    "auctionID": 1
                },
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
                },
                {
                    "auctionID": 6
                },
                {
                    "auctionID": 7
                },
                {
                    "auctionID": 8
                },
                {
                    "auctionID": 9
                },
                {
                    "auctionID": 10
                },
                {
                    "auctionID": 13
                }
            ],
            "offers":[
                {
                    "offerID": 4
                }
            ],
            "requestInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null
                }
            ],
            "inviteInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null,
                    "offerID": null
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
                    "auctionID": 1
                },
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
                },
                {
                    "auctionID": 6
                },
                {
                    "auctionID": 7
                },
                {
                    "auctionID": 8
                },
                {
                    "auctionID": 9
                },
                {
                    "auctionID": 10
                },
                {
                    "auctionID": 13
                }
            ],
            "offers":[
                {
                    "offerID": 5
                }
            ],
            "requestInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null
                }
            ],
            "inviteInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null,
                    "offerID": null
                }
            ]
        },
        {
            "userId": 5,
            "userName": "Gustav Curan",
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
            "currentType": "Supplier",
            "company": "Teknologkåren",
            "participatingAuctions": [
                {
                    "auctionID": 1
                },
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
                },
                {
                    "auctionID": 6
                },
                {
                    "auctionID": 7
                },
                {
                    "auctionID": 8
                },
                {
                    "auctionID": 9
                },
                {
                    "auctionID": 10
                },
                {
                    "auctionID": 13
                }
            ],
            "offers":[
                {
                    "offerID": 6
                }
            ],
            "requestInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null
                }
            ],
            "inviteInbox":[
                {
                    "time": "2021-02-15T10:30:00.001Z",
                    "status": "null",
                    "auctionID": null,
                    "userID": null,
                    "offerID": null
                }
            ]
        }
    ]
}''';
String getUsers() {
  return users;
}

void setUsers(String newString) {
  users = newString;
}

/*
========================
FILTERS
========================
*/
String filters = '''{
    "referenceSectors": [
        {
            "name": "composites",
            "referenceTypes":[
                {
                    "name": "material",
                    "referenceParameters":[
                        {
                            "name": "fibersType",
                            "values": [
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "glass fibers"
                                },
                                {
                                    "filterValue": "paper fibers"
                                },
                                {
                                    "filterValue": "carbon fiber"
                                },
                                {
                                    "filterValue": "other fibers"
                                }
                            ]
                        },
                        {
                            "name": "resinType",
                            "values": [
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "epoxy"
                                },
                                {
                                    "filterValue": "yxope"
                                }
                            ]
                        },
                        {
                            "name": "recyclingTechnology",
                            "values":[
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "cutting edge"
                                },
                                {
                                    "filterValue": "outdated"
                                }
                            ]
                        },
                        {
                            "name": "sizing",
                            "values":[
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "small"
                                },
                                {
                                    "filterValue": "medium"
                                },
                                {
                                    "filterValue": "large"
                                }
                            ]
                        },
                        {
                            "name": "additives",
                            "values":[
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "deluxe"
                                },
                                {
                                    "filterValue": "minimalistic"
                                }
                            ]
                        }
                    ],
                    "rangeReferenceParameters":[
                        {
                            "name": "fiberLength"
                        },
                        {
                            "name": "volume"
                        }
                    ]
                },
                {
                    "name": "referencetype2",
                    "referenceParameters":[
                        {
                            "name": "parameter1",
                            "values":[
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "good choice"
                                },
                                {
                                    "filterValue": "bad choice"
                                }
                            ]
                        },
                        {
                            "name": "parameter2",
                            "values": [
                                {
                                    "filterValue": "any"
                                },
                                {
                                    "filterValue": "great choice"
                                },
                                {
                                    "filterValue": "not so great choice"
                                }
                            ]
                        }
                    ],
                    "rangeReferenceParameters":[
                        {
                            "name": "volume"
                        }
                    ]
                }
            ]
        }
    ]
}''';
String getFilters() {
  return filters;
}

void setFilters(String newString) {
  filters = newString;
}

/*
========================
CONSUMERAUCTIONDETAILS
========================
*/
String consumerAuctionDetails = '''{
    "auctionDetailsList": [
        {
            "id": 10,
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
            "templateID": 1,
            "bids": [
                {
                    "id": 1,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 2,
                    "keyValuePairs": [
                        {
                            "key": "CompanyName",
                            "value": "IKEA"
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
                    "id": 2,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
                    "keyValuePairs": [
                        {
                            "key": "CompanyName",
                            "value": "DollarStore"
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
            "winningBid": 0
        },
        {
            "id": 11,
            "participants": [
                
            ],
            "templateID": 1,
            "bids": [
                
            ],
            "winningBid": 0
        },
        {
            "id": 13,
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
            "templateID": 1,
            "bids": [
                {
                    "id": 18,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 4,
                    "keyValuePairs": [
                        {
                            "key": "CompanyName",
                            "value": "DollarStore"
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
            "winningBid": 0
        }
    ]
}''';
String getConsumerAuctionDetails() {
  return consumerAuctionDetails;
}

void setConsumerAuctionDetails(String newString) {
  consumerAuctionDetails = newString;
}

/*
========================
SUPPLIERAUCTIONDETAILS
========================
*/
String supplierAuctionDetails = '''{
    "auctionDetailsList": [
        {
            "id": 1,
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
            "templateID": 3,
            "bids": [
                {
                    "id": 3,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 2,
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
                    "id": 4,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 2,
            "participants": [
            ],
            "templateID": 3,
            "bids": [
                {
                    "id": 5,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 2,
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
                    "id": 6,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 5
        },
        {
            "id": 3,
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
            "templateID": 3,
            "bids": [
                {
                    "id": 7,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 4,
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
            "templateID": 3,
            "bids": [
                {
                    "id": 8,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 2,
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
                    "id": 9,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 5,
            "participants": [
                {
                    "userID": 1
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
            "templateID": 3,
            "bids": [
                {
                    "id": 10,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 1,
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
                    "id": 11,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 6,
            "participants": [
                {
                    "userID": 1
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
            "templateID": 4,
            "bids": [
                {
                    "id": 12,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 1,
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
                    "id": 13,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 7,
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
            "templateID": 4,
            "bids": [
                {
                    "id": 14,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 2,
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
                    "id": 15,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 8,
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
            "templateID": 4,
            "bids": [
                {
                    "id": 16,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 9,
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
            "templateID": 4,
            "bids": [
                {
                    "id": 17,
                    "time": "2021-02-15T10:40:00.001Z",
                    "userID": 3,
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
            "winningBid": 0
        },
        {
            "id": 12,
            "participants": [

            ],
            "templateID": 4,
            "bids": [

            ],
            "winningBid": 0
        }
    ]
}''';
String getSupplierAuctionDetails() {
  return supplierAuctionDetails;
}

void setSupplierAuctionDetails(String newString) {
  supplierAuctionDetails = newString;
}

/*
========================
CONSUMERCONTRACTTEMPLATES
========================
*/
String consumerContractTemplates = '''{
    "templates": [
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
String getConsumerContractTemplates() {
  return consumerContractTemplates;
}

void setConsumerContractTemplates(String newString) {
  consumerContractTemplates = newString;
}

/*
========================
SUPPLIERCONTRACTTEMPLATES
========================
*/
String supplierContractTemplates = '''{
    "templates": [
        {
            "id": 3,
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
            "id": 4,
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
            "id": 5,
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
String getSupplierContractTemplates() {
  return supplierContractTemplates;
}

void setSupplierContractTemplates(String newString) {
  supplierContractTemplates = newString;
}

/*
========================
CONSUMERMATERIALAUCTIONS
========================
*/
String consumerMaterialAuctions = '''{
    "materialAuctions": [
        {
            "id": 10,
            "title": "Consumer auction",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 13,
            "title": "Good auction",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 0,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 1,
                "maxFiberLength": 30,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 1,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getConsumerMaterialAuctions() {
  return consumerMaterialAuctions;
}

void setConsumerMaterialAuctions(String newString) {
  consumerMaterialAuctions = newString;
}

/*
========================
SUPPLIERMATERIALAUCTIONS
========================
*/
String supplierMaterialAuctions = '''{
    "materialAuctions": [
        {
            "id": 1,
            "title": "Glass & Co.'s Glass fibre extradorinaire",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-02-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 2,
            "title": "Kiruna Mine",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 0,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-02-15T11:30:00.001Z",
            "referenceSector": "ores",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "iron",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 3,
            "title": "Bob's Plastics",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 3,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "plastic",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 4,
            "title": "Papermaker.com",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "paper fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 5,
            "title": "Carfi Carbon Fibres",
            "ownerID": 2,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "carbon fiber",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 20,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 2,
                "maxVolume": 30
            }
        },
        {
            "id": 6,
            "title": "Testauction 6",
            "ownerID": 2,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 7,
            "title": "GREATEST AUCTION EVER",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 4,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "carbon fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 10,
                "maxVolume": 300
            }
        },
        {
            "id": 8,
            "title": "don't join",
            "ownerID": 2,
            "maxParticipants": 10,
            "currentParticipants": 3,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 9,
            "title": "Testauction 9",
            "ownerID": 2,
            "maxParticipants": 10,
            "currentParticipants": 3,
            "startDate": "2021-02-15T10:30:00+01:00",
            "stopDate": "2021-06-15T11:30:00+01:00",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getSupplierMaterialAuctions() {
  return supplierMaterialAuctions;
}

void setSupplierMaterialAuctions(String newString) {
  supplierMaterialAuctions = newString;
}

/*
========================
CONSUMERMATERIALOFFERS
========================
*/
String consumerMaterialOffers = '''{
    "materialOffers":[
        {
            "id": 1,
            "title": "Title 1",
            "userID": 1,
            "templateID": 6,
            "keyValuePairs": [
                {
                    "key": "Name",
                    "value": "Thule Thulesson"
                },
                {
                    "key": "Amount of money",
                    "value": 25
                }
            ],
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        },
        {
            "id": 2,
            "title": "Title 2",
            "userID": 2,
            "templateID": 6,
            "keyValuePairs": [
                {
                    "key": "Name",
                    "value": "Casper Lundberg"
                },
                {
                    "key": "Amount of money",
                    "value": 1
                }
            ],
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getConsumerMaterialOffers() {
  return consumerMaterialOffers;
}

void setConsumerMaterialOffers(String newString) {
  consumerMaterialOffers = newString;
}

/*
========================
SUPPLIERMATERIALOFFERS
========================
*/
String supplierMaterialOffers = '''{
    "materialOffers":[
        {
            "id": 3,
            "title": "Supplier material offer",
            "userID": 2,
            "templateID": 7,
            "keyValuePairs": [
                {
                    "key": "CompanyName",
                    "value": "Demand and supply Co."
                },
                {
                    "key": "Weight",
                    "value": 10
                },
                {
                    "key": "Amount of money",
                    "value": 200
                },
                {
                    "key": "Quantity",
                    "value": 1000
                },
                {
                    "key": "Time",
                    "value": 2
                }
            ],
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "material",
            "referenceParameters": {
                "fibersType": "glass fibers",
                "resinType": "epoxy",
                "minFiberLength": 2,
                "maxFiberLength": 10,
                "recyclingTechnology": "cutting edge",
                "sizing": "large",
                "additives": "deluxe",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getSupplierMaterialOffers() {
  return supplierMaterialOffers;
}

void setSupplierMaterialOffers(String newString) {
  supplierMaterialOffers = newString;
}

/*
========================
CONSUMEROFFERTEMPLATES
========================
*/
String consumerOfferTemplates = '''{
    "templates": [
        {
            "id": 6,
            "templateStrings": [
                {
                    "text": "I, "
                },
                {
                    "text": " am interested in purchasing units at the starting price of "
                },
                {
                    "text": " EUR per kg. "
                }
            ],
            "templateVariables": [
                {
                    "key": "Name",
                    "valueType": "Text"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                }
            ]
        }
    ]
}''';
String getConsumerOfferTemplates() {
  return consumerOfferTemplates;
}

void setConsumerOfferTemplates(String newString) {
  consumerOfferTemplates = newString;
}

/*
========================
SUPPLIEROFFERTEMPLATES
========================
*/
String supplierOfferTemplates = '''{
    "templates": [
        {
            "id": 7,
            "templateStrings": [
                {
                    "text": ""
                },
                {
                    "text": " is willing to sell each unit weighing "
                },
                {
                    "text": " kg, for the buyout price of "
                },
                {
                    "text": " EUR, our supply is for now at around "
                },
                {
                    "text": " units and our average dispatch time is "
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
                    "key": "Weight",
                    "valueType": "Integer"
                },
                {
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Quantity",
                    "valueType": "Integer"
                },
                {
                    "key": "Time",
                    "valueType": "Integer"
                }
            ]
        },
        {
            "id": 8,
            "templateStrings": [
                {
                    "text": ""
                },
                {
                    "text": " is willing to sell 100 units of certified quality for the buyout price of "
                },
                {
                    "text": " EUR, our dispatch time is on average "
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
                    "key": "Amount of money",
                    "valueType": "Integer"
                },
                {
                    "key": "Time",
                    "valueType": "Integer"
                }
            ]
        }
    ]
}''';
String getSupplierOfferTemplates() {
  return supplierOfferTemplates;
}

void setSupplierOfferTemplates(String newString) {
  supplierOfferTemplates = newString;
}

/*
========================
CONSUMERREFERENCETYPE2AUCTIONS
========================
*/
String consumerReferencetype2Auctions = '''{
    "referencetype2Auctions": [
        {
            "id": 11,
            "title": "Consumer auction2",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 0,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "referencetype2",
            "referenceParameters": {
                "parameter1": "good choice",
                "parameter2": "great choice",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getConsumerReferencetype2Auctions() {
  return consumerReferencetype2Auctions;
}

void setConsumerReferencetype2Auctions(String newString) {
  consumerReferencetype2Auctions = newString;
}

/*
========================
SUPPLIERREFERENCETYPE2AUCTIONS
========================
*/
String supplierReferencetype2Auctions = '''{
    "referencetype2Auctions": [
        {
            "id": 12,
            "title": "Supplier referencetype2 auction",
            "ownerID": 1,
            "maxParticipants": 10,
            "currentParticipants": 0,
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "referencetype2",
            "referenceParameters": {
                "parameter1": "good choice",
                "parameter2": "great choice",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getSupplierReferencetype2Auctions() {
  return supplierReferencetype2Auctions;
}

void setSupplierReferencetype2Auctions(String newString) {
  supplierReferencetype2Auctions = newString;
}

/*
========================
CONSUMERREFERENCETYPE2OFFERS
========================
*/
String consumerReferencetype2Offers = '''{
    "referencetype2Offers":[
        {
            "id": 4,
            "title": "Reference type 2 offer",
            "userID": 1,
            "templateID": 6,
            "keyValuePairs": [
                {
                    "key": "Name",
                    "value": "Thule Thulesson"
                },
                {
                    "key": "Amount of money",
                    "value": 225
                }
            ],
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "referencetype2",
            "referenceParameters": {
                "parameter1": "good choice",
                "parameter2": "great choice",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getConsumerReferencetype2Offers() {
  return consumerReferencetype2Offers;
}

void setConsumerReferencetype2Offers(String newString) {
  consumerReferencetype2Offers = newString;
}

/*
========================
SUPPLIERREFERENCETYPE2OFFERS
========================
*/
String supplierReferencetype2Offers = '''{
    "referencetype2Offers":[
        {
            "id": 5,
            "title": "Supplier reference type 2 offer",
            "userID": 1,
            "templateID": 8,
            "keyValuePairs": [
                {
                    "key": "CompanyName",
                    "value": "Demand and supply Co."
                },
                {
                    "key": "Amount of money",
                    "value": 2000
                },
                {
                    "key": "Time",
                    "value": 2
                }
            ],
            "startDate": "2021-02-15T10:30:00.001Z",
            "stopDate": "2021-04-15T11:30:00.001Z",
            "referenceSector": "composites",
            "referenceType": "referencetype2",
            "referenceParameters": {
                "parameter1": "good choice",
                "parameter2": "great choice",
                "minVolume": 500,
                "maxVolume": 5000
            }
        }
    ]
}''';
String getSupplierReferencetype2Offers() {
  return supplierReferencetype2Offers;
}

void setSupplierReferencetype2Offers(String newString) {
  supplierReferencetype2Offers = newString;
}
