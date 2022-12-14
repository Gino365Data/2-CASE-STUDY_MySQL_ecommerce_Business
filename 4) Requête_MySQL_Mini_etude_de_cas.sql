/* Exploration d'une table de données nommée CLIENT1 avec des fonctions permettant de 
faires des requêtes sur celle-ci. */

/* Je veux voir toutes mes colonnes afin d'avoir une vue globale de l'ensemble des colonnes,
pour ça je vais utiliser SELECT * FROM */
SELECT* FROM CLIENT1;

# je veux voir l'ensemble des client sans leur ville de résidence
SELECT NOM,PRENOM
FROM CLIENT1;

/*je veux seulement avoir les noms de famille sans doublons, car nous avons clients familiaux, 
je veux donc connaître le nombre de ménage dans le sens économique du terme. */
SELECT DISTINCT NOM
FROM CLIENT1;

# je veux avoir la liste des clients résidents à Paris
SELECT * 
FROM CLIENT1
WHERE ville = "PARIS";

/* maintenant, je vais travailler sur la table PRODUITS1 
et filtrer avec la fonction WHERE...AND...OR etc. */

# j'aime bien commencer par faire un SELECT * pour voir l'ensemble de mes colonnes
SELECT * FROM PRODUITS1;

/* Commençons, le gestionnaire des stocks de l'entreprise passe des commandes cette semaine,
il aimerait connaître la liste des produits informatique d'une quantité inférieure à 20 unités en stock. */
SELECT * FROM PRODUITS1
WHERE categorie = "informatique" AND stock <20;

/* le gestionnaire des stocks si je peux lister pour lui
les stylos 4 couleurs ou noir disponibles en stock */
SELECT * FROM PRODUITS1
WHERE nom = "stylos 4 couleurs" OR nom = "stylo noir";
 
 /* Finalememnt, le gestionnaire voudrait un peu plus de précisions concernant les catégories de produit;
il aimerait savoir s'il reste des produits informatique avec un prix unitaire supérieur 18€ 
ou également si un des produits bureautique à une quantité en stock inférieure à 40 unités  */
SELECT * FROM PRODUITS1
WHERE (categorie = 'informatique' AND prix >= 18) 
	OR(categorie = 'bureautique' AND stock <= 40);

/* Je veux selectionner seulement les crayons, clavier et les stylos noir,
 pour cela je fais usage de la commande WHERE...IN   */
 SELECT ordinateur FROM PRODUITS1
 WHERE ordinateur IN ("clavier","crayon","stylo noir");
 
 /* Maintenant, le gestionnaire des stocks voudrait connaître les produits qui ont 
 été commandés entre le 01 mars 2022 au 01 septembre 2022, j'ulise pour cela la fonction BETWEEN  */
SELECT * FROM PRODUITS1
WHERE date_commande_recente BETWEEN "2022-03-01" AND "2022-09-01" ;

/* Maintenant la responsable des ventes a analysé la conjoncture commerciale à moyen terme du secteur, 
il demande donc  au gestionnaire des stocks de NE PAS passer de commandes
pour les produits ayant un prix unitaire compris entre 200 à 1000€. */
SELECT * FROM PRODUITS1
WHERE prix_achat_unitaire NOT BETWEEN 200 AND 1000;

/* Etant donné que nous sommes plusieurs à travailler sur cette base de données, 
certains collaborateurs insèrent les noms de produits au pluriel et d'autres non, 
je veux connaître tous les types de stylos que nous avons en stocks, 
pour cela je vais utiliser la commande LIKE pour afficher le début de mot "stylo"*/ 
SELECT * FROM PRODUITS1
WHERE nom LIKE "sty%";

/* Depuis quelques semaines, le chiffre d'affaires à Nantes et Paris sont en berne, 
le responsable commercial voudrait lancer une opération propotionnelle dans ces deux villes 
pour les clients ayant déjà commandés au moins 10 produits */
SELECT * FROM CLIENT1
WHERE ville LIKE "%s" AND nombre_commandes >=10;

/* Pour éviter des erreurs lors des livraisons, la responsable des ventes aimerait savoir 
si les adresses des clients sont à jour dans la table CLIENT1,afin de relancer par sms ceux non-à-jour: 
1) elle veut la liste des client SANS adresse de livraison enrégistrée,
2) la liste des client SANS adresse de livraison ET SANS adresse de facturation
3) la liste des adresses de livraison des clients si différent des adresses de facturation
4) la liste des clients ayant une adresse de livraison */

# Clients SANS adresse de livraison
SELECT * FROM CLIENT1
WHERE adresse_livraison IS NULL;

# Clients SANS adresse de livraison ET de facturation
SELECT * FROM CLIENT1
WHERE adresse_livraison IS NULL 
	AND adresse_facturation IS NULL;

# la liste des adresses de livraison des clients SI DIFFERENT des adresses de facturation
SELECT * FROM CLIENT1
WHERE adresse_livraison != adresse_facturation;

# Clients AVEC une adresse de livraison
SELECT * FROM CLIENT1
WHERE adresse_livraison IS NOT NULL;

/* pour les fêtes de fin d'année 2022, le responsable commercial voudrait offrir un cadeau 
de remerciement aux plus ancients clients lors des deux premières années d'activité de l'entreprise,
l'entreprise ayant démarée en 2012, le responsable commercial souhaite la liste de ses plus anciens clients  */
SELECT * FROM CLIENT1
ORDER BY date_inscription;

/*   Après réflexion, le responsable commercial voudrait aussi récompenser 
ses trois plus gros clients, il en voudrait une liste si possible. */
SELECT * FROM CLIENT1
ORDER BY depenses_totales DESC;

/* Le gestionnaire des stocks voudrait connaître le prix moyen unitiare de ses produits par catégorie, 
je vais utiliser le GROUP BY avec la fonction AVG. */
SELECT categorie, AVG(prix_achat_unitaire)
FROM PRODUITS1
GROUP BY categorie;

/* La responsable des ventes souhaite également connaître les villes où l'entreprise fait 
le plus de chiffres d'affaires. Je vais aussi utiliser le GROUP BY par ville  et faire la somme des dépenses des clients  */
SELECT ville, SUM(depenses_totales) as CA
FROM CLIENT1
GROUP BY ville
	ORDER BY CA DESC;
    
/* le responsable commercial souhaite connaître les villes 
où l'ensemble des clients ont dépensé au moins 500€   */
SELECT ville, SUM(depenses_totales) as CA
FROM CLIENT1
GROUP BY ville
HAVING CA >=500
	ORDER BY  CA DESC;

SELECT * FROM CLIENT1_SUITE;
/* Afin d'éviter trop de colonnes dans la table client1, l'équipe data avait décidé de la scider en deux, 
aujourd'hui, le responsable commercial voudrait récupérer le nom, prenom, e-mail, et catégorie de produit préféré 
afin de lancer une campagne d'e-mailing  */
SELECT nom, prenom,email, categorie_produit_prefere
FROM Client1
JOIN Client1_suite ON Client1.ID = Client1_suite.idClient1_suite;

/* le responsable commercial souhaite connaître les clients se trouvant en dessous du panier  
moyen des dépenses de la clientèle */

# pour répondre à ce besoin, je vais faire usage de la notion des "sous-requêtes"
SELECT *
FROM Client1
WHERE depenses_totales < (
			SELECT AVG(depenses_totales) 
            FROM client1);







