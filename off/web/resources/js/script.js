/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* global mapboxgl */

mapboxgl.accessToken = 'pk.eyJ1IjoibHNpbmNoaWd1YW5vIiwiYSI6ImNrYmxkcWZuMDAxdW8yem56Ym55cjBoemoifQ.kCJOjoWTm7PIVwQa2KhPYw';

var mapa = new mapboxgl.Map({
    container: 'mapa-mapbox',
    style: 'mapbox://styles/mapbox/streets-v11?optimize=true',
    center: [-79.4651461, -1.0235451],
    zoom: 13
});

var coordinates = document.getElementById('coordinates');

/* FUNCIÓN DE CREAR PUNTO */
function crearMarcador(lng, lat) {
    const marker = new mapboxgl.Marker({
        draggable: true
    }).setLngLat([lng, lat])
            .addTo(mapa);
    marker.on('drag', () => {
        var lngLat = marker.getLngLat();
        coordinates.style.display = 'block';
        coordinates.innerHTML =
                'Longitud: ' + lngLat.lng + '<br />Latitud: ' + lngLat.lat;
    });
}
;

/* CREANDO MAPA AL CARGAR LA PÁGINA */
mapa.on('load', function () {
    mapa.loadImage('./resources/images/custom_marker.png', function (error, image) {
        if (error)
            throw error;
        mapa.addImage('custom-marker', image);
        mapa.addSource('puntosR', {
            'type': 'geojson',
            'data': {
                'type': 'FeatureCollection',
                'features': [
                    {
                        'type': 'Feature',
                        'properties': {
                            'description': 'Universidad Técnica Estatal de Quevedo'
                        },
                        'geometry': {
                            'type': 'Point',
                            'coordinates': [-79.469628, -1.012675]
                        }
                    },
                    {
                        'type': 'Feature',
                        'properties': {
                            'description': 'Hotel Ecológico Riverside'
                        },
                        'geometry': {
                            'type': 'Point',
                            'coordinates': [-79.464596, -1.014617]
                        }
                    }
                ]
            }
        });

        mapa.addLayer({
            'id': 'puntosR',
            'type': 'symbol',
            'source': 'puntosR',
            'layout': {
                'icon-image': 'custom-marker',
                'icon-allow-overlap': true
            }
        });
    });

    mapa.on('click', 'puntosR', function (e) {
        var coordinates = e.features[0].geometry.coordinates.slice();
        var description = e.features[0].properties.description;
        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
            coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }
        new mapboxgl.Popup()
                .setLngLat(coordinates)
                .setHTML(description)
                .addTo(mapa);
    });

    mapa.on('mouseenter', 'puntosR', function () {
        mapa.getCanvas().style.cursor = 'pointer';
    });

    mapa.on('mouseleave', function () {
        mapa.getCanvas().style.cursor = '';
    });

});

/* AÑADIENDO CONTROLES */
mapa.addControl(
        new MapboxGeocoder({
            accessToken: mapboxgl.accessToken,
            language: 'es-ES',
            mapboxgl: mapboxgl
        })
        );

mapa.addControl(
        new mapboxgl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        })
        );

mapa.addControl(new mapboxgl.NavigationControl());

mapa.on('click', function (e) {
    var features = mapa.queryRenderedFeatures(e.point, {
        layers: ['puntosR'] // replace this with the name of the layer
    });
    if (!features.length) {

        /* MODAL */
        let lng = e.lngLat.lng;
        let lat = e.lngLat.lat;

        limpiarFormario();
        $('#latitudtxt').val(lng);
        $('#longitudtxt').val(lat);
        $('#exampleModal').modal('show');
    }
});

function guardarPunto() {
    let direccion = $('#direcciontxt').val();
    let sitio = $('#sitiotxt').val();
    let crimen = $('#motibocbo').val();
    let lng = $('#latitudtxt').val();
    let lat = $('#longitudtxt').val();
    let datos = {
        dir: direccion,
        sit: sitio,
        cri: crimen,
        x: lng,
        y: lat
    };
    console.log(datos);
    $.ajax({
        type: 'POST',
        url: 'test',
        data: datos,
        success: function (msg) {
            if (msg) {
                alert('Datos almacenados éxitosamente');
                limpiarFormario();
                $('#frm').modal('toggle');
            }
        },
        error: function (msg) {
            console.log(msg);
            alert('Ocurrio un error');
        }
    });
}
;

function limpiarFormario() {
    $('#latitudtxt').val('0');
    $('#longitudtxt').val('0');
    $('#direcciontxt').val('');
    $('#sitiotxt').val('');
    $('#motibocbo').val('');
}
;

$('#btnAceptar').click(function () {
    guardarPunto();
});