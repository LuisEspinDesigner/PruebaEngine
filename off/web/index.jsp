<%-- 
    Document   : index
    Created on : 21 sept. 2020, 16:42:50
    Author     : Lemmar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SPACE SIG</title>
        <link rel="icon" href="resources/icon/png-transparent-map-computer-icons-map-logo-map-area.ico">
        <link href="resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="resources/css/style.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.2.1.js"
        integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://api.mapbox.com/mapbox-gl-js/v1.12.0/mapbox-gl.js"></script>
        <link href="https://api.mapbox.com/mapbox-gl-js/v1.12.0/mapbox-gl.css" rel="stylesheet" />
        <script
        src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.min.js"></script>
        <link rel="stylesheet"
              href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.5.1/mapbox-gl-geocoder.css"
              type="text/css" />
    </head>
    <body>
        <div class="contenido">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="#">
                    <img src="resources/icon/png-transparent-map-computer-icons-map-logo-map-area.ico" width="30" height="30" class="d-inline-block align-top" alt="" loading="lazy">

                    SPACE SIG
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">

                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="#" routerLink="active">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" routerLink="active">Features</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>

                    </ul>
                </div>
            </nav> 
        </div>

        <!-- Contenedor del mapa -->

        <div id="mapa-mapbox"></div>

        <!-- Contenedor del coordenadas -->
        <pre id="coordinates" class="coordinates"></pre>



        <!-- Modal to be populated on click -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h2 id="marker_title" class="">REGISTRO DE PUNTO</h2>
                        <div id="frm">
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label for="direcciontxt">Dirección</label>
                                    <input type="text" class="form-control" id="direcciontxt" placeholder="Av. 7 de Octubre y Decima Primera" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label for="sitiotxt">Sitio</label>
                                    <input type="text" class="form-control" id="sitiotxt" placeholder="Hotel San Andrés" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-12 mb-3">
                                    <label for="motibocbo">Delito</label>
                                    <select class="custom-select" id="motibocbo" required>
                                        <option selected disabled value="">Seleccione...</option>
                                        <option value="Omicidio y asesinato">Omicidio y asesinato</option>
                                        <option value="Violencia de Género">Violencia de Género</option>
                                        <option value="Falsificaciones">Falsificaciones</option>
                                        <option value="Robo, hurto, daños, fraudaciones">Robo, hurto, daños, fraudaciones</option>
                                        <option value="Tráfico de estupefacientes">Tráfico de estupefacientes</option>
                                        <option value="Choques">Choques</option>
                                        <option value="Tráfico de influencias">Tráfico de influencias</option>
                                        <option value="Negociaciones prohibidas">Negociaciones prohibidas</option>
                                        <option value="Contra la ordenación del territorio">Contra la ordenación del territorio</option>
                                        <option value="Detención ilegal">Detención ilegal</option>

                                        <option value="Secuestro">Secuestro</option>
                                        <option value="Amenaza">Amenaza</option>
                                        <option value="Tortura">Tortura</option>
                                        <option value="Contra la integridad moral">Contra la integridad moral</option>
                                        <option value="Calumnia e injuria">Calumnia e injuria</option>
                                        <option value="Agresión sexual, abuso sexual y acoso sexual">Agresión sexual, abuso sexual y acoso sexual</option>
                                        <option value="Allanamiento de morada">Allanamiento de morada</option>
                                        <option value="Impago de tenciones">Impago de tenciones</option>
                                        <option value="Sustracción de menores">Sustracción de menores</option>
                                        <option value="Delito contra extranjeros">Delito contra extranjeros</option>

                                        <option value="Delito contra patrimonios históricos">Delito contra patrimonios históricos</option>
                                        <option value="Delito de incendios">Delito de incendios</option>
                                        <option value="Tráfico y depósitos de armas">Tráfico y depósitos de armas</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="col-md-6 mb-3">
                                    <label for="latitudtxt">Latitud</label>
                                    <fieldset disabled>
                                        <input type="text" class="form-control" id="latitudtxt" value="">
                                    </fieldset>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="longitudtxt">Longitud</label>
                                    <fieldset disabled>
                                        <input type="text" class="form-control" id="longitudtxt" value="">
                                    </fieldset>
                                </div>
                            </div>
                            <button id="btnAceptar" class="btn btn-primary" type="button" >Guardar</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- LIBRERÍAS -->
        <script src="resources/js/popper.min.js" type="text/javascript"></script>
        <script src="resources/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- SCRIPT DE MAPBOX -->
        <script src="resources/js/script.js" type="text/javascript"></script>

    </body>
</html>
