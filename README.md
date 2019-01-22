First database
Description
Enregistrement de données récupérées sur Internet sous trois formats : JSON, Google Sheets et CSV.

Structure
app/scrapper.rb = contient l'objet effectuant la récupération de données + l'enregistrement au format choix choisi
views/index.rb = permet de lancer la programme et de choisir le format d'enregistrement
views/done.rb : finalise le programme
Le programme s'exécute à partir du terminal via la commande ruby app.rb depuis la racine
