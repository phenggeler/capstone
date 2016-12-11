// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function tmpFunction(name, work, fwork, town, ftown, school, liked) {
  var site = "https://www.facebook.com/search/str/";
  var x = 0;
  if (name && name.length > 0){
  	var names = name.split(" ");
		site = site+names[0];
		for (i =1; i<names.length; i++){
			site = site+"%20"+names[i];
		}
		site = site+"/users-named/intersect";
		x = 1;
  }
  if (work && work.length > 0){
		var works = work.split(" ");
		if (!x){
			site = site+works[0]
		}else{
		site = site+"/str/"+works[0];
		}
		for (i =1; i<works.length; i++){
			site = site+"%20"+works[i];
		}
		site = site+"/pages-named/employees/present/intersect";
		x = 1;
  }
   if (fwork && fwork.length > 0){
		var fworks = fwork.split(" ");
		if(!x){
			site = site+fworks[0];
		}else{
		site = site+"/str/"+fworks[0];
		}
		for (i =1; i<fworks.length; i++){
			site = site+"%20"+fworks[i];
		}
		site = site+"/pages-named/employees/past/intersect";
		x=1;
  }
   if (town && town.length > 0){
		var towns = town.split(" ");
		if(!x){
			site = site+towns[0];
		}else{
		site = site+"/str/"+towns[0];
		}
		for (i =1; i<towns.length; i++){
			site = site+"%20"+towns[i];
		}
		site = site+"/pages-named/residents/present/intersect";
		x=1;
  }
  if (ftown && ftown.length > 0){
		var ftowns = ftown.split(" ");
		if(!x){
			site = site+ftowns[0];
		}else{
		site = site+"/str/"+ftowns[0];
		}
		for (i =1; i<ftowns.length; i++){
			site = site+"%20"+ftowns[i];
		}
		site = site+"/pages-named/residents/past/intersect";
		x=1;
  }
  if (school && school.length > 0){

		var schools = school.split(" ");
		 if(!x){
  			site = site +schools[0];
  		}else{
  			site = site+"/str/"+schools[0];
  		}
		for (i =1; i<schools.length; i++){
			site = site+"%20"+schools[i];
		}
		site = site+"/pages-named/students/intersect";
		x=1;
  }
    if (liked && liked.length > 0){
		var likeds = liked.split(" ");
		 if(!x){
  			site = site +likeds[0];
  		}else{
  			site = site+"/str/"+likeds[0];
  		}
		for (i =1; i<likeds.length; i++){
			site = site+"%20"+likeds[i];
		}
		site = site+"/pages-named/likers/intersect";
		x=1;
  }
	window.open(site,'_blank');
}
