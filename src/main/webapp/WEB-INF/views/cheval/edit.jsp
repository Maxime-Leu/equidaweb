<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Cheval, model.Race, java.util.ArrayList, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Equida - Modifier un cheval</title>
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
                    <h2 class="text-center">Modifier le Cheval</h2>
                    <hr>

                    <% 
                        Cheval c = (Cheval)request.getAttribute("pCheval"); 
                        
                        // Formatage de la date pour l'input HTML5 (yyyy-MM-dd)
                        String dateVal = "";
                        if(c.getDateNaissance() != null) {
                            dateVal = new SimpleDateFormat("yyyy-MM-dd").format(c.getDateNaissance());
                        }
                    %>

                    <form action="<%= request.getContextPath() %>/cheval-servlet/edit" method="POST" class="form-horizontal">
                        
                        <input type="hidden" name="id" value="<%= c.getId() %>">

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Nom :</label>
                            <div class="col-sm-9">
                                <input type="text" name="nom" class="form-control" value="<%= c.getNom() %>" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Sexe :</label>
                            <div class="col-sm-9">
                                <select name="sexe" class="form-control">
                                    <option value="M" <%= (c.getSexe() != null && c.getSexe().equals("M")) ? "selected" : "" %>>Mâle</option>
                                    <option value="F" <%= (c.getSexe() != null && c.getSexe().equals("F")) ? "selected" : "" %>>Femelle</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">N° SIRE :</label>
                            <div class="col-sm-9">
                                <input type="text" name="sire" class="form-control" value="<%= c.getSire() != null ? c.getSire() : "" %>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Date de naissance :</label>
                            <div class="col-sm-9">
                                <input type="date" name="dateNaissance" class="form-control" value="<%= dateVal %>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">Race :</label>
                            <div class="col-sm-9">
                                <select name="race" class="form-control">
                                    <% 
                                        ArrayList<Race> lesRaces = (ArrayList<Race>)request.getAttribute("pLesRaces");
                                        for (Race r : lesRaces) { 
                                            String selected = (c.getRace() != null && r.getId() == c.getRace().getId()) ? "selected" : "";
                                    %>
                                        <option value="<%= r.getId() %>" <%= selected %>><%= r.getNom() %></option>
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
                                <a href="<%= request.getContextPath() %>/cheval-servlet/list" class="btn btn-default">Annuler</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>