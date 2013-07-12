message_api
===========

Marketing Opt-Ins - simple REST API using Grape and ActiveRecord.

### Create database
Database configuration in config/dtabase.yml
Create database using rake
```
$ rake db:creata
$ rake db:migrate
```
Create test database
```
$ DATABASE_ENV=test rake db:creata
$ DATABASE_ENV=test rake db:migrate
```

### Run app
```
rackup
```


### Create an opt-in
```
$ curl -X POST -H "Content-Type: application/json" -d '{"email":"test@gmail.com","permission_type":"permanent","channel":"email","company_name":"xyz"}' http://localhost:9292/opt_ins

{"opt_in":{"channel":"email","company_name":"xyz","email":"test@gmail.com","first_name":null,"id":1,"last_name":null,"mobile":null,"permission_type":"permanent"}}
```

### List opt-ins
```
$ curl http://localhost:9292/opt_ins

[{"email":"test@gmail.com","mobile":null,"first_name":null,"last_name":null,"permission_type":"permanent","channel":"email","company_name":"xyz","links":[{"rel":"self","href":"/optins/1"}]}]
```

### Update an opt-in
```
$ curl -X PUT -H "Content-Type: application/json" -d '{"permission_type":"one-time"}' http://localhost:9292/opt_ins/1

true
```

### Delete an opt-in
```
$ curl -X DELETE -H "Content-Type: application/json" http://localhost:9292/opt_ins/1

{"opt_in":{"channel":"email","company_name":"xyz","email":"test@gmail.com","first_name":null,"id":1,"last_name":null,"mobile":null,"permission_type":"one-time"}}
```
