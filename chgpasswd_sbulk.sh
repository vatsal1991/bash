# simple command to change passwords for small group of users using "chpasswd"

for user in tom dick harry; do echo $user:123456 |chpasswd ; done

