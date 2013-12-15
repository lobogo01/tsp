
#map = L.map('map-canvas') #.setView([51.505, -0.09], 13)
#L.tileLayer('http://{s}.tile.cloudmade.com/<<<<API-key>>>>/997/256/{z}/{x}/{y}.png', {
#    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
#    maxZoom: 18
#}).addTo(map)

#L.marker([51.5, -0.09]).addTo(map).bindPopup("<b>Hello world!</b><br />I am a popup.").openPopup()

#mapLayer = MQ.mapLayer()
#map = L.map('map-canvas', { layers: mapLayer })
#L.control.layers({
#    'Map': mapLayer,
#    'Satellite': MQ.satelliteLayer(),
#    'Hybrid': MQ.hybridLayer()
#}).addTo(map)

map = L.map('map-canvas')
L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© <a href="http://openstreetmap.org">OpenStreetMap</a> contributors',
    maxZoom: 18
}).addTo(map);


class Input
    constructor: (spec) ->
        @map = spec.map
        @read_cities(spec.filename)

    read_json: (filename) ->
        request = new XMLHttpRequest()
        request.open("GET", filename, false)
        request.send()
        eval(request.responseText)

    read_cities: (filename) ->
        #cities = @read_json(filename)
        cities = [
            {"lb":48.1458923,"mb":17.107137299999977,"name":"Bratislava"},
            {"lb":48.72100529999999,"mb":21.25779990000001,"name":"Košice"},
            {"lb":48.9979058,"mb":21.23960729999999,"name":"Prešov"},
            {"lb":49.2215903,"mb":18.741951900000004,"name":"Žilina"},
            {"lb":48.3148451,"mb":18.087986399999977,"name":"Nitra"},
            {"lb":48.736277,"mb":19.14619170000003,"name":"Banská Bystrica"},
            {"lb":48.3804163,"mb":17.587819399999944,"name":"Trnava"},
            {"lb":49.0652929,"mb":18.921855800000003,"name":"Martin"},
            {"lb":48.8944464,"mb":18.040752800000064,"name":"Trenčín"},
            {"lb":49.055188,"mb":20.30143279999993,"name":"Poprad"},
            {"lb":48.7707098,"mb":18.620953699999973,"name":"Prievidza"},
            {"lb":48.5758623,"mb":19.12562909999997,"name":"Zvolen"},
            {"lb":49.1169161,"mb":18.448152899999968,"name":"Považská Bystrica"},
            {"lb":47.9860672,"mb":18.16406489999997,"name":"Nové Zámky"},
            {"lb":48.7556769,"mb":21.918385899999976,"name":"Michalovce"},
            {"lb":48.94352689999999,"mb":20.56798100000003,"name":"Spišská Nová Ves"},
            {"lb":47.7625785,"mb":18.129413200000045,"name":"Komárno"},
            {"lb":48.2192923,"mb":18.60114820000001,"name":"Levice"},
            {"lb":48.9338752,"mb":21.910721200000012,"name":"Humenné"},
            {"lb":49.2920835,"mb":21.27628089999996,"name":"Bardejov"},
            {"lb":49.0834456,"mb":19.612485200000037,"name":"Liptovský Mikuláš"},
            {"lb":49.08154740000001,"mb":19.304323000000068,"name":"Ružomberok"},
            {"lb":48.5892328,"mb":17.834046599999965,"name":"Piešťany"},
            {"lb":48.5614719,"mb":18.17160869999998,"name":"Topoľčany"},
            {"lb":48.3289346,"mb":19.665348499999936,"name":"Lučenec"},
            {"lb":49.4383046,"mb":18.79132359999994,"name":"Čadca"},
            {"lb":48.96069550000001,"mb":18.171883999999977,"name":"Dubnica nad Váhom"},
            {"lb":48.3833442,"mb":20.018358000000035,"name":"Rimavská Sobota"},
            {"lb":48.6275765,"mb":18.361415599999987,"name":"Partizánske"},
            {"lb":48.1520972,"mb":17.873885200000018,"name":"Šaľa"},
            {"lb":47.9916214,"mb":17.620651500000008,"name":"Dunajská Streda"},
            {"lb":48.62338159999999,"mb":21.71997340000007,"name":"Trebišov"},
            {"lb":48.8875263,"mb":21.68531889999997,"name":"Vranov nad Topľou"},
            {"lb":48.4302016,"mb":17.799393399999985,"name":"Hlohovec"},
            {"lb":48.8060729,"mb":19.643817799999965,"name":"Brezno"},
            {"lb":48.9875164,"mb":22.15195689999996,"name":"Snina"},
            {"lb":48.2882776,"mb":17.266969300000028,"name":"Pezinok"},
            {"lb":48.67652469999999,"mb":17.36395760000005,"name":"Senica"},
            {"lb":48.7563795,"mb":17.83269710000002,"name":"Nové Mesto nad Váhom"},
            {"lb":48.7187376,"mb":18.25917979999997,"name":"Bánovce nad Bebravou"}
        ]
        @name = []
        @pos = []
        for c in cities
        	@name.push(c.name)
        	@pos.push([c.lb, c.mb])
        @N = @pos.length
        console.log(@N)
        @map.fitBounds(@pos)

    make_markers: () ->
        for i in [0...@N] by +1
            cityIcon = L.divIcon({html: "<div><span>#{i}</span></div>", className: 'city-marker'})
            L.marker(@pos[i], { title: @name[i], icon: cityIcon }).addTo(@map);

class TSPSolver
    constructor: (@D) ->
    solve: () -> []

class NearestNeighbor extends TSPSolver
    constructor: (@D) ->
    solve: () ->
        used = @N * [false]
        used[0] = true
        c = 0
        pi = [0]
        for i in [0...@N] by +1
            min = 9999999
            k = 0
            for j in [0...@N] by +1
                if not used[j] and @D[c][j] < min
                    min = @D[c][j]
                    k = j
            pi.push(k)
            c = k
            used[k] = true
        pi.push(pi[0])
        #make_path(pi)
        #out.append(dist(pi) + "\n")

class Opt2 extends NearestNeighbor
    constructor: (@D) ->
    solve: () ->
        pi = super()
        progress = true
        while progress
            progress = false
            for i in [0...@N] by +1
                for j in [i+2...@N] by +1
                    if @D[pi[i]][pi[i+1]] + @D[pi[j]][pi[j+1]] > @D[pi[i]][pi[j]] + @D[pi[i+1]][pi[j+1]]
                        make_xchg_line(pi[i],pi[j])
                        make_xchg_line(pi[i+1],pi[j+1])
                        reverse(I+1, J)
                        #clear_path()
                        #clear_xchg_lines();
                        make_path(pi)
                        out.append(dist(pi) + "\n")
                        progress = true

I = new Input({filename: 'svk.in', map: map})
I.make_markers()
