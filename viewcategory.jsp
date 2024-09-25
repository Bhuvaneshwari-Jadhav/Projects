<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Categories</title>
    <!-- Company Standard Stylesheets and Libraries -->
    <link href="<c:url value='/resources/CSS/login.css'/>" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
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
            text-align: center;
        }
        thead th {
            background-color: #333;
            color: white;
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
        .text-center{
        margin-top:30px;}
    </style>
    <script>
        $(document).ready(function() {
            // Initialize DataTables plugin
            $('#categoryTable').DataTable();

            // Confirm delete action
            $('.delete-btn').on('click', function() {
                var categoryId = $(this).data('id');
                $('#confirmDeleteModal').modal('show'); // Show the modal
                $('#deleteCategoryBtn').data('id', categoryId); // Pass the category ID to the delete button
            });

            $('#deleteCategoryBtn').on('click', function() {
                var categoryId = $(this).data('id');
                window.location.href = 'deletebycatid?categoryid=' + categoryId; // Redirect to the delete URL
            });
        });
    </script>
</head>
<body>
    <!-- Include Header/Navigation -->
    <jsp:include page="adminpro.jsp"></jsp:include>

    <div class="boxx">
        <h3 class="text-center">All Categories</h3>
        
        <div id="gridShow">
            <table id="categoryTable" class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Action</th>                      
                    </tr>
                </thead>
                <tbody>
                    <%
                    int count = 0;
                    %>
                    <c:forEach var="e" items="${catlist}">
                        <%
                        ++count;
                        %>
                        <tr>
                            <td><%= count %></td>
                            <td>${e.htype}</td>
                            <td>
                                <!-- Delete button with a confirmation popup -->
                                <button class="btn btn-danger delete-btn" data-id="${e.categoryid}">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal for Delete Confirmation -->
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
                    Are you sure you want to delete this category?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="deleteCategoryBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS for Modal functionality -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>
