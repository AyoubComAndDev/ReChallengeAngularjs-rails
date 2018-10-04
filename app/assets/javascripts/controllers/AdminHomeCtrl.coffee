@app.controller 'homeAdminCtrl', ($scope,Auth,$location,$http,$window,adminService) ->
    $scope.showMsgValid = false
    $scope.showMsgError = false
    $scope.ActivePageUser = 1
    $scope.ActivePageDNT = 1
    $scope.ActivePageDT = 1

    $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
    if $scope.user?
      $location.path '/login' if $scope.user.role isnt "admin"

      adminService.getAllUsers().then (res) ->
        $scope.users = res.data
        $scope.pages = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error users not found !' ,error

      adminService.getAllDemandsT().then (res) ->
        $scope.demandesT = res.data
        $scope.pagesDT = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error demandsT not found !' ,error

      adminService.getAllDemandsNonT().then (res) ->
        $scope.demandesNonT = res.data
        $scope.pagesDNT = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error users not found !' ,error
     else
       $location.path '/login'

    $scope.find = ->
        $scope.motCle = "" if !$scope.motCle?
        Indata = {p : $scope.ActivePageDNT }
        $http.get('/conge/search/'+$scope.motCle,Indata).then (res) ->
          $scope.demandesNonT = res.data.data
          $scope.pagesDNT = (num for num in [1..res.data.total])
        ,(error)->
          console.log error,'Search error'

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $window.localStorage.clear()
            $location.path '/login'
        ,(error) ->
            console.log error

    $scope.saveIdCongeDemand = (id) ->
        $scope.idCongeDemand = id

    $scope.sendReject = ->
            Indata = {motifR : $scope.motifR, etat :'Réfusé', id : $scope.idCongeDemand }
            adminService.sendReject(Indata).then (res) ->
              angular.element('#exampleModal').modal('hide')
              $scope.showMsgValid = true
              $scope.demandesNonT = res.data
              adminService.getAllUsers().then (res) ->
                $scope.users = res.data
                $scope.pages = (num for num in [1..res.total])
              ,(error) ->
                console.log 'error users not found !' ,error

              adminService.getAllDemandsT().then (res) ->
                $scope.demandesT = res.data
                $scope.pagesDT = (num for num in [1..res.total])
              ,(error) ->
                console.log 'error demandsT not found !' ,error
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true

    $scope.sendAccept = (event,id,user_id,db,df,solde) ->
            event.preventDefault()
            adminService.sendAccept(id,user_id,db,df,solde).then (res) ->
              $scope.showMsgValid = true
              $scope.demandesNonT = res.data
              $scope.pagesDNT = (num for num in [1..res.total])
              adminService.getAllUsers().then (res) ->
                $scope.users = res.data
                $scope.pages = (num for num in [1..res.total])
              ,(error) ->
                console.log 'error users not found !' ,error

              adminService.getAllDemandsT().then (res) ->
                $scope.demandesT = res.data
                $scope.pagesDT = (num for num in [1..res.total])
              ,(error) ->
                console.log 'error demandsT not found !' ,error
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true
            ,(error) ->
              console.log error , 'Error reject demand'
              $scope.showMsgError = true


    $scope.getModelInfo = (id) ->
            $http.get('/conge/getUserCongeModel/'+id).then (model) ->
                 $scope.myModel = model.data.data
            ,(error)->
                console.log error,'model not found'

    $scope.reloadUserPage = (p) ->
            $scope.ActivePageUser = p
            $http.get('/GetAllUsers/'+p).then (res) ->
                 $scope.users = res.data.data
            ,(error)->
                console.log error,'page users not found'

    $scope.reloadDNTPage = (p) ->
            if $scope.motCle
              $scope.ActivePageDNT = p
              $http.get('/conge/search/'+$scope.motCle+'/'+p).then (res) ->
                console.log 'search ', res
                $scope.demandesNonT = res.data.data
                $scope.pagesDNT = (num for num in [1..res.data.total])
              ,(error)->
                console.log error,'Search error'
            else
              $scope.ActivePageDNT = p
              $http.get('conge/GetAllDemandsNonT/'+p).then (res) ->
                $scope.demandesNonT = res.data.data
              ,(error)->
                console.log error,'page demandsNonT not found'

    $scope.reloadDTPage = (p) ->
            $scope.ActivePageDT = p
            $http.get('conge/GetAllDemandsT/'+p).then (res) ->
                 $scope.demandesT = res.data.data
            ,(error)->
                console.log error,'page demandsNonT not found'
