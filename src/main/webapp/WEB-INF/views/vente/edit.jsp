<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Vente, model.Lieu, model.CategVente, java.util.ArrayList, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Equida - Modifier une vente</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        body { padding-top: 70px; background-color: #f4f7f6; }
        .form-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="form-card">
                    <h2 class="text-center">Modifier la Vente</h2>
                    <hr>

                    <% 
                        Vente v = (Vente)request.getAttribute("pVente"); 
                        // FIX DATE : Formatage obligatoire en yyyy-MM-dd pour l'input date
                        String dateVal = "";
                        if(v.getDateDebutVente() != null) {
                            dateVal = new SimpleDateFormat("yyyy-MM-dd").format(v.getDateDebutVente());
                        }
                    %>

                    <form action="<%= request.getContextPath() %>/vente-servlet/edit" method="POST" class="form-horizontal">
                        <input type="hidden" name="id" value="<%= v.getId() %>">

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Nom :</label>
                            <div class="col-sm-9">
                                <input type="text" name="nom" class="form-control" value="<%= v.getNom() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Date de début :</label>
                            <div class="col-sm-9">
                                <input type="date" name="dateDebutVente" class="form-control" value="<%= dateVal %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Lieu (Ville) :</label>
                            <div class="col-sm-9">
                                <select name="idLieu" class="form-control">
                                    <% 
                                        ArrayList<Lieu> lesLieux = (ArrayList<Lieu>)request.getAttribute("pLesLieux");
                                        for (Lieu l : lesLieux) { 
                                            String selected = (l.getId() == v.getLieu().getId()) ? "selected" : "";
                                    %>
                                        <option value="<%= l.getId() %>" <%= selected %>><%= l.getVille() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Catégorie :</label>
                            <div class="col-sm-9">
                                <select name="idCateg" class="form-control">
                                    <% 
                                        ArrayList<CategVente> lesCategs = (ArrayList<CategVente>)request.getAttribute("pLesCategVentes");
                                        for (CategVente c : lesCategs) { 
                                            String selected = (c.getId() == v.getCategVente().getId()) ? "selected" : "";
                                    %>
                                        <option value="<%= c.getId() %>" <%= selected %>><%= c.getLibelle() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <hr>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-9">
                                <button type="submit" class="btn btn-success">
                                    <span class="glyphicon glyphicon-save"></span> Enregistrer les modifications
                                </button>
                                <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-default">Annuler</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>