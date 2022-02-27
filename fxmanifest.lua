  fx_version 'cerulean'
  game 'gta5'
  
  description 'A MultiJob Script for QBCore RP Servers'
  authour 'Kmack710#0710'
  version '1.0.0'
  
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'data/server.lua'
}
  
shared_scripts { 
    'config.lua'
}
  
  client_scripts {
    'data/client.lua'
}
  
lua54 'yes'