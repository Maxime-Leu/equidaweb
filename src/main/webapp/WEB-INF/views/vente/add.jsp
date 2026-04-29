<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Lieu" %>
<%@ page import="model.CategVente" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Equida - Ajouter une vente</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body { padding-top: 70px; background-color: #f4f7f6; }
        .form-card { 
            background: white; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
        }
        .btn-save { background-color: #27ae60; color: white; }
        .btn-save:hover { background-color: #219150; color: white; }
    </style>
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="form-card">
                    <h2 class="text-center">Nouvelle Vente</h2>
                    <hr>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("message") %>
                        </div>
                    <% } %>

                    <form action="add" method="POST" class="form-horizontal">
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Nom de la vente :</label>
                            <div class="col-sm-9">
                                <input type="text" name="nom" class="form-control" placeholder="Ex: Vente d'Automne" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Date de début :</label>
                            <div class="col-sm-9">
                                <input type="date" name="dateDebutVente" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Lieu (Ville) :</label>
                            <div class="col-sm-9">
                                <select name="idLieu" class="form-control" required>
                                    <option value="">-- Sélectionner une ville --</option>
                                    <% 
                                        ArrayList<Lieu> lesLieux = (ArrayList<Lieu>)request.getAttribute("pLesLieux");
                                        if (lesLieux != null) {
                                            for (Lieu l : lesLieux) { 
                                    %>
                                        <option value="<%= l.getId() %>"><%= l.getVille() %></option>
                                    <% 
                                            }
                                        } 
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Catégorie :</label>
                            <div class="col-sm-9">
                                <select name="idCateg" class="form-control" required>
                                    <option value="">-- Sélectionner une catégorie --</option>
                                    <% 
                                        ArrayList<CategVente> lesCategs = (ArrayList<CategVente>)request.getAttribute("pLesCategVentes");
                                        if (lesCategs != null) {
                                            for (CategVente c : lesCategs) { 
                                    %>
                                        <option value="<%= c.getId() %>"><%= c.getLibelle() %></option>
                                    <% 
                                            }
                                        } 
                                    %>
                                </select>
                            </div>
                        </div>

                        <hr>

                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button type="submit" class="btn btn-save">
                                    <span class="glyphicon glyphicon-ok"></span> Enregistrer la vente
                                </button>
                                <a href="list" class="btn btn-default">Annuler</a>
                            </div>
                        </div>

                    </form>
                </div>
                <p class="text-center" style="margin-top: 20px;">
                    <a href="<%= request.getContextPath() %>/index.jsp">Retour à l'accueil</a>
                </p>
            </div>
        </div>
    </div>

</body>
</html>