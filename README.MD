## This is a simple Multijob script I made cause too many people were charging $15+ for something so simple.
![image](https://i.imgur.com/pwxro0E.png)

## Add this to your Database! Without this it wont work! Be sure to change payment amount below to the amount of your unemployeed Paycheque 
```sql
ALTER TABLE `players`
	ADD COLUMN `job_two` TEXT NULL DEFAULT '{"name":"unemployed","onduty":true,"payment":10,"label":"Civilian","grade":{"name":"Freelancer","level":0},"isboss":false}';
```

## Dependancies 
- QBCore 
- Qb-menu or Renzucontextmenu 
