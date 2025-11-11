## ➤ 1. Lister toutes les commandes avec le nom du client

```sql
SELECT c.id_commande, cl.nom AS client, c.date_commande
FROM commande c
JOIN client cl ON c.id_client = cl.id_client;

```

---

## ➤ 2. Voir le détail complet des commandes (clients + produits)

```sql
SELECT cl.nom AS client, c.id_commande, p.nom AS produit, d.quantite, p.prix,
       (p.prix * d.quantite) AS total_ligne
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
JOIN detail_commande d ON c.id_commande = d.id_commande
JOIN produit p ON d.id_produit = p.id_produit
ORDER BY c.id_commande;

```

---

## ➤ 3. Calculer le total de chaque commande

```sql
SELECT c.id_commande, cl.nom AS client,
       SUM(p.prix * d.quantite) AS total_commande
FROM commande c
JOIN client cl ON c.id_client = cl.id_client
JOIN detail_commande d ON c.id_commande = d.id_commande
JOIN produit p ON d.id_produit = p.id_produit
GROUP BY c.id_commande, cl.nom
ORDER BY total_commande DESC;

```

---

## ➤ 4. Classement des clients selon leurs dépenses totales

```sql
SELECT cl.nom AS client,
       SUM(p.prix * d.quantite) AS total_depense,
       RANK() OVER (ORDER BY SUM(p.prix * d.quantite) DESC) AS classement
FROM client cl
JOIN commande c ON cl.id_client = c.id_client
JOIN detail_commande d ON c.id_commande = d.id_commande
JOIN produit p ON d.id_produit = p.id_produit
GROUP BY cl.nom;

```

---

## ➤ 5. Rechercher les commandes passées après une certaine date

```sql
SELECT id_commande, date_commande
FROM commande
WHERE date_commande > '2025-11-03'
