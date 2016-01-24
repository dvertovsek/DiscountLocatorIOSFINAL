//: Playground - noun: a place where people can play

import UIKit

var str = "Ovo je playground - app za isprobavanje dijelova koda"
var str1 = "Ovo je varijabla - implicitno zadana"
let implicitDouble=70.0 //konstanta
let explicitDouble: Double=70

let labela = "Sirina je"
let width = 199
let widthLabel = labela + String(width)

let jabuke = 666
let kruske = 333
let stringJabuke = "Imam \(jabuke) komada jabuka"
let stringVoce = "Imam \(jabuke+kruske) komada voća"
//opcionalne - varijable/konstante koje mogu biti nil (slično null)
//sintaksa: var/let ime: tip? = ...
var neOpcionalniInt = 10
//neOpcionalniInt=nil ovo baca error
var opcionalniInt: Int? = 10
opcionalniInt = nil
var delcec: String? = nil

/*da se dobije underlying tip opcionanalne varijable/konstante koristi se operator ?, eksplicitno definirana varijabla + eksplicitno pridruzivanje */
let opcionalniInt2 :Int? = 10 //eksplicitno def opc. var
let stvarniInt: Int = opcionalniInt2! //eksplicitno pridr

/* deprecirano u swiftu 2, naime treba se eksplicitno definirati varijabla kojoj se želi dodijeliti vrijednost nekog drugog tipa castanjem, ovo više ne radi:
var mojstring = "8"
var moguciInt = Int(mojstring)
print(moguciInt) */

var mojstring = "8"
var moguciInt: Int? = mojstring.toInt()


var polje = ["mačka", "pas","kontrabas"]
var asocPolje = ["Malcom": "U sredini",
                 "Dewey": "Najmanji"]
asocPolje["Malcom"]

var praznoPolje = [String]()
var prazniRijecnik = [String: Float] ()

//ako je tip polja prepoznatljiv od strane kompajlera tada se ono moze isprazniiti
polje = []
asocPolje = [:]

//---- Kontrolne strukture


let individRezultati = [75, 23, 103, 84, 15, 777]

var skorTima = 0

for rezultat in individRezultati {
    if(rezultat > 50) {
        skorTima += 5
    }
    else {
        skorTima += 1
    }
    
}

skorTima

var opcString: String? = nil
print (opcString == nil)
var pozdrav: String? = ""
//ukoliko opCstring nije nil tada ce se izvrsit pridruzivanje vrijednosti konst. ime i ući u blok
if let ime = opcString {
    pozdrav = "Hello \(ime)"
}
else {
    pozdrav = "I can change that in a hurry..."
}

let feferona = "ljuta feferona"
switch feferona {
    case "blaga":
        print("feferona je blaga")
    case let x where x.hasPrefix("ljuta"):
        print ("Fakat je ljuta")
    case "ljuta feferona":
        print("feferona je ljuta")
default: //mora postojati default
         print("Meni su dobre bilokakve feferone")
}

var n=2
while n<100 {
    n = n*2
}

n

var m = 2

do{ //u swiftu 1 repeat
    m = m * 2
} while m < 100

var prviBrojac = 0

for i in 0..<4 { //..<strogo manje  - ne ukljucuje 4
    prviBrojac += i
}
prviBrojac

var drugiBrojac = 0

for i in 0...4 { //... ukljucuje i 4
    drugiBrojac += i
}
drugiBrojac

//---funkcije
//sintaksa func imeFunkcije(argument:tip)->povratni tip
func pozdravi(ime: String, dan: String, rucak: String) ->String {
    return "Bok \(ime), danas je \(dan). i za rucak cete imati \(rucak)"
}
pozdravi("Matt Romney", "Nedjelja", "ajngemahtec")

//funkcija - vise povratnih vrijednosti
func izracunajStat(ulPolje:[Int]) -> (min: Int, max:Int, sum: Int){
    var minim = ulPolje[0]
    var maxim = ulPolje[0]
    var suma = 0
    
    for broj in ulPolje {
        if broj > maxim {
            maxim = broj
        }
        else if broj < minim {
            minim = broj
            
        }
        suma += broj
    }
    return (minim,maxim,suma)
}
func voidFunc (){ //voidfunkcija
    print ("ja sam tu")
}
voidFunc()
//definiranje konstante koja je zapravo objekt u koji se pohranjuju sve vrijednosti iz funkcije izracunajStat
let statistike = izracunajStat ([5,3,100,3,9])
statistike.0
statistike.min
statistike.sum

//funkcija - neodredeni broj argumenata spremljenih u polje

func sumaBrojeva (brojevi: Int...) -> Int {
    var suma = 0
    for broj in brojevi{
        suma+=broj
    }
    return suma
}

sumaBrojeva()
sumaBrojeva(20,30,40,60,708)

//ugnježđene funkcije - pristup varijablama u vanjskoj funkc.

func vratiDvadeset() -> Int {
    var y = 10
    func dodajDeset(){ //ovo je poput imenovanog closure-a
        y += 10
    }
    dodajDeset()
    return y
}
vratiDvadeset()

//funkcije mogu vratiti drugu funkciju kao vrijednost odnosno prosljeđuju parametar drugoj, ugnježđenoj funkciji koja radi posao (funkcije su first-class type)

func vratiFunkciju() -> (String->Int) { //argument druge -> povratni tip druge
    func dodajDeset(brojString: String)->Int{
        return brojString.toInt()! + 10
    }
    return dodajDeset
}

var objFunkcijeDodaj10=vratiFunkciju() //objekt = funkcija, slicno jscriptu
objFunkcijeDodaj10("10")


//funkcije mogu primiti drugu funkciju kao argument
//ovdje je drugi argument funkcija koja prima int i vraca bool
func imaLiPogodaka(listaBrojeva: [Int] , uvjet: Int->Bool)->Bool{
    for broj in listaBrojeva{
        if(uvjet(broj)){
            return true
        }
    }
    return false
}

func manjiOdDeset(broj: Int) -> Bool {
    return broj < 10
}
var brojcici = [20,3,5,60]
imaLiPogodaka(brojcici, manjiOdDeset)

//eksperiment - neparne mapiraj na 0, parne ostavi
let brojciciNeparniNula=brojcici.map( //mapira trenutno polje na druge vrijednosti, navedeno unutar closure-a
    {
        (broj:Int) -> Int in //argument je broj odnosno el. polja
        let result = broj%2 != 0 ? 0:broj
        return result
    }
)
//closure - i - kod unutar closure funkcije ima pristup svim varijablama unutar razine gdje je kreiran
//https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
//brojevi
let brojciciPutaDeset=brojcici.map( //mapira trenutno polje na druge vrijednosti, navedeno unutar closure-a
    {
        (broj:Int) -> Int in //argument je broj odnosno el. polja
        let result = broj * 10
        return result
    }
)
brojciciPutaDeset

//isto to ali skraceno - ako se tip closure-a implicitno podrazumijeva
let brojciciPutaDesetDrugaVer = brojcici.map({ broj in 3 * broj})
brojciciPutaDesetDrugaVer
//sort - usporedba closurea
 //funkcija sort - dio objekta polja odr. tipa - njoj se TREBA proslijediti funkcija po kojoj ce usporediti elemente polja (argument)
//bez closurea (funkcija je zasebno definirana)
func uzlazno (b1:Int, b2:Int) -> Bool{
    return b1 < b2
}
brojcici.sort(uzlazno)

//definiranje argumenta kao closure funkcije - standardna procedura
brojcici.sort ({
    (b1:Int, b2:Int) -> Bool //parametri i povratni tip (funkcija za usp. vraća bool)
    in
    return b1>b2 //izraz po kojem se usporeduje silazni sort
})
print(brojcici)
//implicitno pridruzivanje tipa argumentima (na temelju tipa polja) - e.g. from the context

brojcici.sort({
    b1,b2 in //kompajler zna da moraju b1 i b2 biti int pošto je polje int
    return b1<b2
})
brojcici.sort({
    b1,b2 in //kompajler zna da moraju b1 i b2 biti int pošto je polje int
    b1<b2 //za jednostavne izraze (single expr.) ne treba return
})
brojcici.sort ({
     return $0<$1 //$0 I $1 su shorthand parametri koji se usporeduju
})
print(brojcici)

//-- klase i objekti
/*REVOLUCIONARNO
Za razliku od drugih prog. jezika, swift ne trazi kreiranje interfacea odvojenog od implementacije istog za klase i strukture. U swiftu se definira klasa ili struktura unutar fajla i eksterni interface za tu klasu je automatski kreiran!
*/
class Lik {
    var brojStranica = 0
    var name: String
    init (name: String){ //konstruktor
        self.name = name //self = this
    }
    func opis() -> String {
        return "Lik s \(brojStranica) stranica."
    }
}
var kvadrat = Lik(name: "kvadrat") // nema new
kvadrat.brojStranica=4
var opis = kvadrat.opis()

/*
    operatori pristupa - bazirani na konceptu modula i source fileova
    modul u swiftu - jedinica distribucije, fw/app koji je bildan i shippan kao jedinica, i moze se ukljuciti rijecju import
    source file - datoteka unutar modula
    private - entiteti dostupni unutar istog source filea
    internal - dostupni u bilokojem source fileu modula gdje je trenutni kreiran
    public - dostupni iz svih modula aplikacije
    po defaultu - internal
*/
class Kvadrat: Lik {
    var duljinaStranice: Double {
        /* NOVO
        willset i didset su slušači prilikom settanja propertya willset - prije setanja, after poslije
        koriste se kako bi se automatiziralo settanje propertya
        pritom koristec ugradene varijable newValue/oldWalue
        ne pozivaju se prilikom inicijalizacije već prilikom promjene vrijednosti
        */
        willSet {
            println("Stara vrijednost je \(duljinaStranice), nova vrijednost je \(newValue)");
        }
        //vrijednost je settana
        didSet {
            println("Stara vrijednost je \(oldValue), nova vrijednost je \(duljinaStranice)");
        }

    }
    init(duljinaStranice: Double, ime: String){
        self.duljinaStranice=duljinaStranice
        super.init(name: ime)
        brojStranica = 4
    }
    var opseg: Double {
        get { //primjer gettera
            return duljinaStranice * 4
        }
    }
    func povrsina()-> Double {
        return duljinaStranice * duljinaStranice
    }
    override func opis() -> String {
        return "Kvadrat sa stranicama duljine \(duljinaStranice)"
    }

}

let test = Kvadrat (duljinaStranice: 5.9, ime: "Kvadratko")
test.povrsina()
test.opis()
test.opseg
test.duljinaStranice = 8


//strukture - jako slicne klasama - glavna razlika instanca strukture se prilikom razmjene kopira a instance klasa se razmjenjuju po referenci  - tj. varijable instance drze referencu na isti mem. prostor, ne kopiju
//strukture = value types, klase = refference types

//enumeracije = također vrijednosni tipovi

//protokoli = sučelja

protocol Schteker {
    var opis: String {get}
    mutating func podesi() // mutating ispred func - za modificiranje svojstva strukture iz funkcije (nakon povratka iz metode svojstvo strukture je izmjenjeno, podsjetnik - struktura je value type)
}
class Klasa: Schteker {
    var opis: String = "Jednostavna klasa koja"
    func podesi(){
        opis += " slijedi protokol (conforms to /adopts protocol)"
    }
}

struct Struktura: Schteker {
    var opis: String = "Jednostavna struktura koja"
    mutating func podesi(){ //glavna razlika u odnosu na klasu
        opis += " slijedi protokol (conforms to /adopts protocol)"
    }
}

var a = Klasa()
a.podesi()
let aOpis = a.opis

var s = Struktura()
s.podesi()
let sOpis = s.opis

/* enumeracije u swiftu drukčije nego kod c-like jezika
razlika: 
    u c-like jezicima imao si vrijednost izrazenu slovčano i "sirovu vrijednost" = broj
    u swiftu - fleksibilnije - ne moraju imati vrijednost ispod haube, no ukoliko je imaju ona moze biti string, float ili nesto trece, ne nuzno int
*/


enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var planet = Planet.Earth

switch planet {
    case .Earth: print ("Pozdrav Zemljanine")
    default: print ("Pozdrav Izvanzemaljče o.O")
}
/*primjer sa enumeracijama na barkodu*/

enum Barcode {
    case UPCA(Int, Int, Int, Int) //signature (definicija) za UPCA
    case QRCode(String) //signature za QRCode
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP") //postaje novi barkod tipa QRCode (implicitno se zna da je iz enum Barcode - zbog prijašnje dodjele vrijednosti)

//ispis sa switchem - ispisuje se samo za jedan case - ovisno kojeg je tipa barkod - UPCA ili QRCode
//napomena : switch je u swiftu exhaustive - odnosno moraju svi mogući slučajevi unutar nj. biti obuhvaćeni(ili mora postojati default) - probaj zakomentirati .QRCode case i vidi što će se dogoditi
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let productCode):
    print("QR code: \(productCode).")
}

//c-like enumeracija

enum PlanetRaw: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var rawPlanet = PlanetRaw.Mars.rawValue
switch rawPlanet{
    case 4 : print("Pao si s Marsa")
    default: print("Pozdrav ne-Maršanine")
}



