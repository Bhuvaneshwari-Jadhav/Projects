<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All City Records</title>
    <style>
        body {
            background-color: black;
        }
        .boxx {
            margin-left: 400px;
            margin-right: 100px;
             border-radius: 10px; /* Rounded corners for modern look */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top:20px;
            padding:30px;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
            text-align: center; /* Center align all text in table cells */
        }
        thead th {
            background-color: #333;
            color: white;
            text-align: center;
        }
        tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }
        tbody tr:nth-child(even) {
            background-color: #ffffff;
        }
        tbody tr:hover {
            background-color: #ddd;
        }
        .btn {
            margin: 5px;
        }
    </style>
    <link href="<c:url value='/resources/CSS/login.css' />" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
    <script type="text/javascript" src="<c:url value='/resources/JS/search.js' />"></script>
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>

    <div class="boxx">
        <h3 class="text-center">All City Records</h3>
        
        <div id="gridShow">
            <table id="cityTable" class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>City Name</th>
                        <th>DELETE</th>
                        <th>UPDATE</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    int count = 0;
                    %>
                    <c:forEach var="e" items="${clist}">
                        <%
                        ++count;
                        %>
                        <tr>
                            <th scope="row"><%= count %></th>
                            <td>${e.getCname()}</td>
                            <td><button class="btn btn-danger" data-toggle="modal" data-target="#confirmDeleteModal" data-id="${e.getId()}">DELETE</button></td>
                            <td><a href="updatebyid?id=${e.getId()}" class="btn btn-primary btn-sm">Edit</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this city?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="deleteCityBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('#cityTable').DataTable();

            // Attach city ID to the modal when it's shown
            $('#confirmDeleteModal').on('show.bs.modal', function(event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var cityId = button.data('id'); // Extract city ID from data-id attribute
                var modal = $(this);
                $('#deleteCityBtn').data('id', cityId); // Store the city ID in the delete button
            });

            // Perform delete operation on confirmation
            $('#deleteCityBtn').on('click', function() {
                var cityId = $(this).data('id');
                window.location.href = "deletebyid?id=" + cityId;
            });
        });

        function searchName(value) {
            $("#cityTable tr").each(function() {
                var found = false;
                $(this).each(function() {
                    if ($(this).text().toLowerCase().indexOf(value.toLowerCase()) >= 0) {
                        found = true;
                    }
                });
                if (found == true) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    </script>

    <!-- Bootstrap JS for Modal functionality -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>
