@app.directive 'ngWelcome', ->
  scope : {
    user: "="
  }
  template :"<h1> &#160; Bienvenue  {{user.nom}} {{user.prenom}} ! <small>Votre solde de congé est : {{user.solde}} </small></h1>"
