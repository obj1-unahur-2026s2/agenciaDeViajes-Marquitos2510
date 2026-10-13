
class Pack {

    var duracion
    var precioBase
    var beneficiosEspeciales = []
    var coordinador

    method conocerDuracion() {
        return duracion;
    }

    method conocerPrecioBase() {
        return precioBase;
    }

    method conocerBeneficiosEspeciales() {
        return beneficiosEspeciales;
    }

    method conocerCoordinador() {
        return coordinador;
    }

    
    method calcularValorFinal() {
        const beneficioVigentes = beneficiosEspeciales.filter({beneficio => beneficio.estaVigente()})

        const costoBeneficio = beneficioVigentes.sum({beneficio => beneficio.conocerCosto()})

        return precioBase + costoBeneficio;
    }

    method esPackPremium()



}


class PackNacional inherits Pack{

    var provinciaDestino
    var actividadesIncluidas = []

    method conocerProvinciaDestino() {
        return provinciaDestino;
    }

    method conocerActividadesIncluidas() {
        return actividadesIncluidas;
    }


    override method esPackPremium(){

        var esPremium = false

        if ((duracion > 10 ) and coordinador.altamenteCalificado(coordinador)) {
            esPremium = true
        }

        return esPremium
    }

}

class PackInternacional inherits Pack{

    var paisDestino
    var cantidadEscalas = 0
    var esLugarDeInteres = true


    method conocerCantidadEscalas() {
        return cantidadEscalas;
    }

    method esLugarDeInteres() {
        return esLugarDeInteres;
    }

    method conocerPaisDestino() {
        return paisDestino;
    }

    override method calcularValorFinal() {
        const valor = super()
        return (valor * 1.2)
    }

     override method esPackPremium(){

        var esPremium = false

       if ((duracion > 20 ) and (cantidadEscalas < 1) and esLugarDeInteres) {
            esPremium = true
        }

        return esPremium
    }

}


class Coordinador {

    var cantidadDeViajes
    var estaMotivado = true
    var aniosDeExperiencia
    var rol

    method validarRol(nuevoRol) {

        if (nuevoRol == "Guía" || nuevoRol == "Asistente logístico" || nuevoRol == "Acompañante") {
            return nuevoRol
        }
        throw new Exception(message = "El rol que ha ingresado no es válido")
    }
    
    method estaMotivado() = estaMotivado

    method cambiarMotivacion(){
        estaMotivado = not estaMotivado
        return estaMotivado
    }


    method cambiarRol(nuevoRol) {
        rol = self.validarRol(nuevoRol)
    }

    method cumpleSegunSuRol(coordinador) {
        var calificado = true

        if ((rol == "Guía") && coordinador.estaMotivado()){
            return calificado
        } 
        
        if ((rol == "Asistente logístico") and (aniosDeExperiencia > 3)) {
            return calificado
        } 
        
        if (rol == "Acompañante") {
            return not calificado
        }

        return not calificado
    }



    method altamenteCalificado(coordinador) {
        return (coordinador.cumpleSegunSuRol(self) and cantidadDeViajes > 20)
    }



}


class PackProvinciales inherits PackNacional {

    var cantidadDeCiudadesAvisitar

    method conocerCantidadDeCiudadesDestino() {
        return cantidadDeCiudadesAvisitar;
    }

    override method esPackPremium(){
        return (+(actividadesIncluidas.size() > 4) and (cantidadDeCiudadesAvisitar > 5) and
                beneficiosEspeciales.count({beneficio => beneficio.estaVigente()}))
    }

    override method calcularValorFinal() {
        
        const precioFi = super() 
        return (precioFi * 1.05)

    }

}


class Beneficio{

    var tipo
    var costo
    var estaVigente = true

    method conocerTipo(){
        return tipo
    }

    method conocerCosto (){
        return costo
    }

    method cambiarVigencia(){
        estaVigente = not estaVigente
    }

    method estaVigente(){
        return estaVigente
    }



}