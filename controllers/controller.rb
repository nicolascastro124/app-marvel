require 'rest-client'
require 'json'
require_relative '../class/Character'
class Controller

#metodo para obtener el json entregado por el servidor    
def get (url)
    response = RestClient::Request.new(
    :method => :get,
    :url => url
    ).execute

    return JSON.parse response.to_str
end

#metodo para obtener el creador con mas comics publicados
def getCreators(hash, publickey, ts)

    url = "https://gateway.marvel.com:443/v1/public/creators?hash=#{hash}&apikey=#{publickey}&ts=#{ts}"
    result = get(url)
    $count = result['data']['count']
    $mayor = 0
    for $i in 0 ... $count
       $obtenido = result['data']['results'][$i]['comics']['available']
        if $obtenido > $mayor
          $mayor = $obtenido
          $nombre = result['data']['results'][$i]['fullName']
          $id = result['data']['results'][$i]['id']
        end
    end
    arry = [$id,$nombre]
    return arry
end

#metodo para obtener los id de comics asociados a un creador
def getComicsByCreatorId(hash, publickey, ts, id)

    url = "https://gateway.marvel.com:443/v1/public/creators/#{$id}/comics?hash=#{hash}&apikey=#{publickey}&ts=#{ts}"
    result = get(url);

    ary = Array.new
    $count = result['data']['count']

    for $i in 0 ... $count
        $idComic= result['data']['results'][$i]['id']
        ary.unshift($idComic)
    end
    return ary
end

#metodo para obtener los ID de personajes asociados a los comics
def getCharactersID(hash, publickey, ts, ary)

    arraych = Array.new
    for $i in 0... ary.size
        id = ary[$i]
        url = "https://gateway.marvel.com:443/v1/public/comics/#{id}/characters?hash=#{hash}&apikey=#{publickey}&ts=#{ts}"
        result = get(url)
        c = result['data']['count']
        if c > 0 then
            y = 0
            while c > y do 
                $idCh = result['data']['results'][y]['id']
                arraych.unshift($idCh)
                arraych = arraych.uniq
                y += 1
            end
        end        
    end
    return arraych
end

#metodo para obtener ID y nombre de un personaje buscandolo por su id
def getCharacterbyID(hash, publickey, ts, ary)
    array = Array.new
    for index in 0... ary.size
        url = "https://gateway.marvel.com:443/v1/public/characters/#{ary[index].inspect}?hash=#{hash}&apikey=#{publickey}&ts=#{ts}"
        result = get(url)
        id = result['data']['results'][0]['id']
        name = result['data']['results'][0]['name']
        char = Character.new(id,name)
        array.unshift(char)
    end
return array
end

#metodo para la impresion en pantalla de los datos
def mostrarCharacters(ary)
    for i in 0... ary.size
       char = Character.new(ary[i].id, ary[i].name)
       puts "ID: #{char.id} -- #{char.name}"
    end
end
end