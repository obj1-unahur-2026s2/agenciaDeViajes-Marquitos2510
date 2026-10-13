
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
        var valorFinal = precioBase;

        if (beneficiosEspeciales.size() > 0) {
            valorFinal += beneficiosEspeciales.sum() 
        }

        return valorFinal;
    }


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

    override   method calcularValorFinal() {
        super()
        return (valorFinal * 1.2)
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
    

    method cambiarRol(nuevoRol) {
        rol = validarRol(nuevoRol)
    }

   

}