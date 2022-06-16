require_relative 'controllers/md5'
require_relative 'controllers/controller'
puts "Ingrese clave publica (Public Key)"
publickey = gets
puts "Ingrese clave privada (Private Key)"
privatekey = gets
ts= 'desafio'

encriptacion = Md5.new()
hash = encriptacion.md5(publickey,privatekey,ts)
api = Controller.new()
creador = api.getCreators(hash, publickey, ts) # Array con los datos del creador con mas comics
idsComics = api.getComicsByCreatorId(hash, publickey, ts, creador[0])
idsCharacters = api.getCharactersID(hash, publickey, ts, idsComics)
characters = api.getCharacterbyID(hash, publickey, ts, idsCharacters)

puts "
**********************************************
Creador con mas comics disponibles: #{creador[1]}
**********************************************
PERSONAJES
**********************************************"
api.mostrarCharacters(characters)
