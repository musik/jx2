//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require bootstrap-collapse
//= require angular
//= require angular_filters

function ShopsCtrl($scope,$http) {
  $scope.predicate = "alexa"
  $http.get('/yaodian.json').success(function(data){
    $scope.hide_table = true
    $scope.shops =  data;
  })
  $scope.search = function(){
    $http.get('/yaodian.json?q=' +  $scope.shopq).success(function(data){
      $scope.shops =  data;
    })
  }
}
var App = angular.module('Shops',['filters']);
//angular.module('myApp', ['filters']);
App.controller('ShopsCtrl',['$scope','$http',ShopsCtrl])
