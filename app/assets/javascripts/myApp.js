


app.controller("myController2",function($scope,$http){
    $scope.users=[];
    $scope.idModelAdminSend='';
    $scope.showPagination=true;
    $http({
        method: 'get',
        url: 'http://localhost:3000/api/v1/usersj'
    }).then(function (response) {
        console.log(response.data.data, 'Users');
        $scope.users = response.data.data;
    },function (error){
        console.log(error, 'can not get data.');
    });

    $scope.demandesT=[];
    $scope.demandesNonT=[];
    $http({
        method: 'get',
        url: 'http://localhost:3000/getDemandeT'
    }).then(function (response) {
        console.log(response.data, 'getdemandesNonT');
        $scope.demandesNonT = response.data.data;
    },function (error){
        console.log(error, 'can not get getdemandesNonT.');
    });

    $http({
        method: 'get',
        url: 'http://localhost:3000/getDemandeNonT'
    }).then(function (response) {
        console.log(response.data, 'getDemandeT');
        $scope.demandesT = response.data.data;
    },function (error){
        console.log(error, 'can not get getDemandeT.');
    });
    $scope.sendchangeState=function(id){
        $scope.idModelAdminSend=id;
        console.log($scope.idModelAdminSend ,'MY idModelAdminSend');
    }
    $scope.sendAccept=function(event,id,user_id,db,df,sole){
        event.preventDefault();
        var _MS_PER_DAY = 1000 * 60 * 60 * 24;
        var a=new Date(db);var b=new Date(df);
        var utc1 = Date.UTC(a.getFullYear(), a.getMonth(), a.getDate());
        var utc2 = Date.UTC(b.getFullYear(), b.getMonth(), b.getDate());
        var res=Math.floor((utc2 - utc1) / _MS_PER_DAY);
        var resF=sole-res;
        console.log('RES F!',resF);
        var Indata = {etat :'Accepté',user_id:user_id,sole:resF};
        $http({
            method: 'post',
            url: 'http://localhost:3000/updateOK/'+id,
            headers: {'Content-Type': 'application/json'},
            params: Indata
        }).then(function (response) {
            $scope.demandesNonT = response.data.data;
            $scope.showMsg2=true;
            $http({
                method: 'get',
                url: 'http://localhost:3000/getDemandeNonT'
            }).then(function (response) {
                console.log(response, 'getDemandeNONT');
                $scope.demandesT = response.data.data;
            },function (error){
                console.log(error, 'can not get getDemandeT.');
            });
        },function (error){
            console.log(error, 'can not get decision accept .');
        });
    };
    $scope.sendReject=function(event){
        var Indata = {'motifR':$scope.motifR, etat :'Réfusé'}
        $http({
            method: 'post',
            url: 'http://localhost:3000/updateNO/'+$scope.idModelAdminSend,
            headers: {'Content-Type': 'application/json'},
            params: Indata
        }).then(function (response) {
            console.log(response ,'MY resp !');
            $scope.demandesNonT = response.data.data;
            console.log($scope.demandesNonT ,'here demandesNonT !')
            $scope.showMsg2=true;
            $http({
                method: 'get',
                url: 'http://localhost:3000/getDemandeNonT'
            }).then(function (response) {
                console.log(response, 'getDemandeNONT');
                $scope.demandesT = response.data.data;
            },function (error){
                console.log(error, 'can not get getDemandeT.');
            });
        },function (error){
            console.log(error, 'can not get decision accept .');
        });
    };

    $scope.find=function(){
        if($scope.motCle==undefined){
            $scope.motCle='';
        }
        $http({
            method: 'get',
            url: 'http://localhost:3000/search/'+$scope.motCle
        }).then(function (response) {
            console.log(response.data, 'getdemandesNonT');
            if( $scope.motCle==''){
                $scope.showPagination=true;
            }else {
                $scope.showPagination=false;
            }
            $scope.demandesNonT = response.data.data;
        },function (error){
            console.log(error, 'can not get getDemandesNonT.');
        });
    };
    $scope.sendModel=function(id){
        $scope.myModel2=[];
    $http({
        method: 'get',
        url: 'http://localhost:3000/myModelUser/'+id
    }).then(function (response) {
        $scope.myModel2 = response.data.data;
        console.log($scope.myModel2, 'model');
    },function (error){
        console.log(error, 'can not get data model.');
    });
    };
});
app.controller("myController",function($scope,$http){
    $scope.sendModel=function(id){
        $scope.myModel=[];
    $http({
        method: 'get',
        url: 'http://localhost:3000/myModelUser/'+id
    }).then(function (response) {
        console.log(response.data.data, 'model');
        $scope.myModel = response.data.data;
    },function (error){
        console.log(error, 'can not get data model.');
    });
    };
    $scope.user=null;
    $http({
        method: 'get',
        url: 'http://localhost:3000/getUser'
    }).then(function (response) {
        console.log(response.data.data, 'User');
        $scope.user = response.data.data;
        $scope.conge=[];
    $http({
        method: 'get',
        url: 'http://localhost:3000/getCongesDemande/'+$scope.user.id
    }).then(function (response) {
        console.log(response.data, 'congeDemande');
        $scope.conge = response.data.data;
    },function (error){
        console.log(error, 'can not get data conges demand !.');
    });
    },function (error){
        console.log(error, 'can not get data.');
    });



    $scope.sendDemande=function(){
        $scope.showMsg=false;
        if(angular.isUndefined($scope.dateF) || $scope.dateF === null)return;
        var Indata = {'user_id':$scope.user.id,'date_debut':$scope.dateD,'date_fin':$scope.dateF, 'motifAb':$scope.motifAb}
        $http({
            method: 'post',
            url: 'http://localhost:3000/api/v1/usersj',
            headers: {'Content-Type': 'application/json'},
            params: Indata
        }).then(function (response) {
            console.log(response, 'Post !');
            $scope.dateF='';$scope.dateD='';$scope.motifAb='';
            $scope.showMsg=true;
        },function (error){
            console.log(error, 'can not save demand !.');
        });
    };
});
