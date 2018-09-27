@app.controller 'authCtrl', ($scope,Auth,$location,$http) ->
    $scope.isLogedIn = false;

    $http.get('/GetLoggedUserInfo').then (res) ->
            console.log 'res user json', res
            $scope.user = res
            if res.data.data?
                if res.data.data.role is "user"
                     $location.path '/UserHome'
                else
                    $location.path '/AdminHome'
            if !res.data.data?
                $scope.isLogedIn = true;
        ,(error)->
            console.log error,' User is not logged in'
            $scope.isLogedIn = true;

    $scope.submit = ->
        Auth.login( $scope.user ).then ->
            $http.get('/GetLoggedUserInfo').then (res) ->
                console.log 'res user json', res
                $scope.user = res
                if res.data.data?
                    if res.data.data.role is "user"
                         $location.path '/UserHome'
                    else
                         $location.path '/AdminHome'
            ,(e) ->
                console.log e,' User is not logged in'
        ,(error) ->
            console.log error
