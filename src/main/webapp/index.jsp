<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Equida | Dashboard</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    
    <style>
        body { 
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            padding-top: 80px;
        }
        .welcome-header {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            padding: 60px 0;
            border-radius: 0 0 30px 30px;
            margin-bottom: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .card-custom {
            background: white;
            border: none;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .card-custom:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.1);
        }
        .icon-box {
            font-size: 40px;
            color: #3498db;
            margin-bottom: 15px;
        }
        .btn-custom {
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/header.jsp" />

    <div class="welcome-header text-center">
        <div class="container">
            <h1 style="font-weight: 600;">Tableau de Bord Equida</h1>
            <p class="lead" style="opacity: 0.8;">Gestion simplifiée des ventes et du catalogue équin</p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="card-custom">
                    <div class="icon-box">
                        <span class="glyphicon glyphicon-shopping-cart"></span>
                    </div>
                    <h3>Ventes aux enchères</h3>
                    <p class="text-muted">Planifiez, modifiez et gérez les sessions de ventes actuelles.</p>
                    <a href="<%= request.getContextPath() %>/vente-servlet/list" class="btn btn-primary btn-custom">Gérer les ventes</a>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card-custom">
                    <div class="icon-box" style="color: #e67e22;">
                        <span class="glyphicon glyphicon-knight"></span>
                    </div>
                    <h3>Catalogue Equin</h3>
                    <p class="text-muted">Accédez à la liste des chevaux, leurs races et leurs pedigrees.</p>
                    <a href="<%= request.getContextPath() %>/cheval-servlet/list" class="btn btn-warning btn-custom">Gérer les chevaux</a>
                </div>
            </div>
        </div>
        
        <footer class="text-center" style="margin-top: 50px; color: #95a5a6;">
            <p>&copy; 2026 Equida Management System - Maxime SIO</p>
        </footer>
    </div>

</body>
</html>