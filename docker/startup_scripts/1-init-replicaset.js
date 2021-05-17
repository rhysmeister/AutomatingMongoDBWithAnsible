rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb1.docker_mongonet:27017"},
    { _id: 1, host: "mongodb2.docker_mongonet:27017"},
    { _id: 2, host: "mongodb3.docker_mongonet:27017"}
  ]
});

db = db.getSiblingDB('admin');
while(rs.status()['myState'] != 1) {
  print("State is not yet PRIMARY. Waiting...");
  sleep(1000);
}
db.createUser(
	{
		user: "admin",
		pwd: "secret",
		roles: [ { role: "root", db: "admin" } ]
	}
);
