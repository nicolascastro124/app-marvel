#Uso de la API de Marvel
#https://developer.marvel.com/docs
require_relative 'controllers/md5'
require_relative 'controllers/controller'
puts "Ingrese clave publica (Public Key)"
publickey = gets
puts "Ingrese clave privada (Private Key)"
privatekey = gets
#timestamp solicitada por el servidor para realizar peticiones para este caso la definiremos como "desafio"
ts= 'desafio' 

encriptacion = Md5.new()
hash = encriptacion.md5(publickey,privatekey,ts)
api = Controller.new()
# Array con los datos del creador con mas comics
creador = api.getCreators(hash, publickey, ts) 
#id de comics asociados al creador 
idsComics = api.getComicsByCreatorId(hash, publickey, ts, creador[0])
#id de personajes asociados a los comics
idsCharacters = api.getCharactersID(hash, publickey, ts, idsComics) 
#lista de los personajes obtenidos
characters = api.getCharacterbyID(hash, publickey, ts, idsCharacters) 

puts "
**********************************************
Creador con mas comics disponibles: #{creador[1]}
**********************************************
PERSONAJES
**********************************************"
api.mostrarCharacters(characters)
