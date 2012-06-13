/*
 * jQuery UI addresspicker @VERSION
 *
 * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI/Progressbar
 *
 * Depends:
 *   jquery.ui.core.js
 *   jquery.ui.widget.js
 *   jquery.ui.autocomplete.js
 */
(function(a,b){a.widget("ui.addresspicker",{options:{appendAddressString:"",draggableMarker:!0,regionBias:null,mapOptions:{zoom:10,center:new google.maps.LatLng(46,2),scrollwheel:!0,mapTypeId:google.maps.MapTypeId.SATELLITE},elements:{map:!1,lat:!1,lng:!1,locality:!1,country:!1}},marker:function(){return this.gmarker},map:function(){return this.gmap},updatePosition:function(){this._updatePosition(this.gmarker.getPosition())},reloadPosition:function(){this.gmarker.setVisible(!0),this.gmarker.setPosition(new google.maps.LatLng(this.lat.val(),this.lng.val())),this.gmap.setCenter(this.gmarker.getPosition())},selected:function(){return this.selectedResult},_create:function(){this.geocoder=new google.maps.Geocoder,this.element.autocomplete({source:a.proxy(this._geocode,this),focus:a.proxy(this._focusAddress,this),select:a.proxy(this._selectAddress,this)}),this.lat=a(this.options.elements.lat),this.lng=a(this.options.elements.lng),this.locality=a(this.options.elements.locality),this.country=a(this.options.elements.country),this.options.elements.map&&(this.mapElement=a(this.options.elements.map),this._initMap())},_initMap:function(){this.lat&&this.lat.val()&&(this.options.mapOptions.center=new google.maps.LatLng(this.lat.val(),this.lng.val())),this.gmap=new google.maps.Map(this.mapElement[0],this.options.mapOptions),this.gmarker=new google.maps.Marker({position:this.options.mapOptions.center,map:this.gmap,draggable:this.options.draggableMarker}),google.maps.event.addListener(this.gmarker,"dragend",a.proxy(this._markerMoved,this)),this.gmarker.setVisible(!1)},_updatePosition:function(a){this.lat&&this.lat.val(a.lat()),this.lng&&this.lng.val(a.lng())},_markerMoved:function(){this._updatePosition(this.gmarker.getPosition())},_geocode:function(a,b){var c=a.term,d=this;this.geocoder.geocode({address:c+this.options.appendAddressString,region:this.options.regionBias},function(a,c){if(c==google.maps.GeocoderStatus.OK)for(var d=0;d<a.length;d++)a[d].label=a[d].formatted_address;b(a)})},_findInfo:function(a,b){for(var c=0;c<a.address_components.length;c++){var d=a.address_components[c];if(d.types.indexOf(b)!=-1)return d.long_name}return!1},_focusAddress:function(a,b){var c=b.item;if(!c)return;this.gmarker&&(this.gmarker.setPosition(c.geometry.location),this.gmarker.setVisible(!0),this.gmap.fitBounds(c.geometry.viewport)),this._updatePosition(c.geometry.location),this.locality&&this.locality.val(this._findInfo(c,"locality")),this.country&&this.country.val(this._findInfo(c,"country"))},_selectAddress:function(a,b){this.selectedResult=b.item}}),a.extend(a.ui.addresspicker,{version:"@VERSION"}),Array.indexOf||(Array.prototype.indexOf=function(a){for(var b=0;b<this.length;b++)if(this[b]==a)return b;return-1})})(jQuery);