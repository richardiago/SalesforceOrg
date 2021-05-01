import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import Leaflet from '@salesforce/resourceUrl/Leaflet';
import LeafletDraw from '@salesforce/resourceUrl/LeafletDraw';

const FIELDS = ['Account.Location__Latitude__s', 'Account.Location__Longitude__s', 'Account.Map__c'];

export default class MapComponent extends LightningElement {

    @track latitude;
    @track longitude;
    @track poligono;
    @track record;
    @track polygon;
    @track drawnItems;

    @api recordId;

    //Pega dados do registro
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS }) 
    account({error, data}){
        if(data){
            this.record = data;
            this.latitude = this.record.fields.Location__Latitude__s.value;
            this.longitude = this.record.fields.Location__Longitude__s.value;
            this.poligono = this.record.fields.Map__c.value;

            this.createMap();
        }
    }

    //Carrega as bibliotecas e css necessários: Leaflet e LeafletDraw
    async createMap(){

        await loadStyle(this, Leaflet + '/leaflet.css');
        await loadStyle(this, LeafletDraw + '/leafletDraw/leaflet.draw.css');
        await loadScript(this, Leaflet + '/leaflet.js');
        await loadScript(this, LeafletDraw + '/leafletDraw/leaflet.draw.js');
        this.initializeMap();
    }

    initializeMap(){
        
        //cria um mapa, com latitutde, longitude, zoom, e coloca na div especificada
        var mymap = L.map(this.template.querySelector('div')).setView([this.latitude, this.longitude], 17);
        
        //adiciona tile ao mapa
        var layer = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
                attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
                
        }).addTo(mymap);
    
        //adiciona marcador ao mapa
        var marker = L.marker([this.latitude, this.longitude]).addTo(mymap);
        
        //desenha um poligono no mapa
        if(this.poligono){
            var pol = this.createPolygonCoordinates();
            this.polygon = L.polygon(pol, {color: 'red'}).addTo(mymap);
            mymap.fitBounds(this.polygon.getBounds());
        }

        //Adiciona controles de edições de forma ao mapa
        this.drawnItems = new L.FeatureGroup();
        mymap.addLayer(this.drawnItems);

        //Adiciona poligono já existente à camada
        if(this.polygon){
            this.drawnItems.addLayer(this.polygon);
        }

        var drawControl = new L.Control.Draw({
            edit: {
                featureGroup: this.drawnItems
            },
            draw: {
                rectangle: false,
                circle: false
            }
        });
        mymap.addControl(drawControl);

        mymap.on('draw:created', this.onCreate.bind(this));
        mymap.on('draw:edited', this.onEdit.bind(this));
    }

    onCreate(e){
        var layer = e.layer;
        var type = e.layerType;
        
        if(type == 'polygon'){
            this.savePolygonCoordinates(layer.getLatLngs().toString());
        }
        this.drawnItems.addLayer(layer);
    }

    onEdit(e){
                
        var layers = e.layers;
        var pontos;
        var camada;

        layers.eachLayer(function (layer) {
            
            camada = layer;
            pontos = camada.getLatLngs().toString();

        });

        this.savePolygonCoordinates(pontos);
        this.drawnItems.addLayer(camada);
    }

    //Pega as coordenadas do poligono já existente no registro
    createPolygonCoordinates(){
        var coordString =  this.poligono.split(',');
        var coordFloat = [];
        var coordAux = [];

        for(var i = 0; i < coordString.length; i+=2){
            coordAux = [parseFloat(coordString[i]), parseFloat(coordString[i+1])];
            coordFloat.push(coordAux);
        }
        
        return coordFloat;
    }

    //Salva as coordenadas do poligono quando o mesmo é criado
    savePolygonCoordinates(coord){
        
        coord = coord.toString();
        var newCoord = coord.replaceAll("LatLng(","");
        newCoord = newCoord.replaceAll(")","");
        newCoord = newCoord.replaceAll(/\s+/g,'');
        //console.log("newCoord "+newCoord);

        let record = {
            fields : {
                Id: this.recordId,
                Map__c : newCoord,
            },
        }

        //faz o update do registro
        updateRecord(record).then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Criação de área",
                    message: "Área criada com sucesso",
                    variant: 'success',
                }),

            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: "Criação de área",
                    message: error.message.body,
                    variant: 'error',
                }),
            );
        });

        return;
    }
}