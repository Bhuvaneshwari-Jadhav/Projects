<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>City Wise Areas</title>
    <style>
        body {
            background-color: black;
        }
        .boxx {
            margin-left: 400px;
            margin-right: 100px;
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top:20px;
            padding:30px;
        }
        .boxx h3 {
            font-weight: bold;
        }
        table {
            width: 100%;
            padding: 10px;
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
    </style>
    <link href="<c:url value='/resources/CSS/login.css'/>" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">
</head>
<body>
    <jsp:include page="adminpro.jsp"></jsp:include>

    <div class="boxx">
        <center><h3>All City Wise Areas</h3></center>
        
        <form action="viewareabycity" method="GET">
            <div class="form-group">
                <select name="id" class="form-control" required>
                    <option value="">Select City</option>
                    <c:forEach var="e" items="${clist}">
                        <option value="${e.getId()}">${e.getCname()}</option>
                    </c:forEach>
                </select>
                <br>
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
        
        <div id="gridShow">
            <table id="cityTable" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Area Name</th>
                        <th>DELETE</th>
                        <th>UPDATE</th>
                    </tr>
                </thead>
                <tbody id="areaList">
                    <%
                        int count = 0;
                    %>
                    <c:forEach var="a" items="${alist}">
                        <%
                            ++count;
                        %>
                        <tr id="area-${a.getAid()}">
                            <th scope="row"><%=count %></th>
                            <td>${a.aname}</td>
                            <td>
                               <button class="btn btn-danger btn-sm" onclick="confirmDelete(${a.getAid()})">Delete</button>
                            </td>
                            <td>
                                <a href="updateareabyaid?aid=${a.getAid()}" class="btn btn-primary btn-sm">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmDeleteLabel">Confirm Deletion</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this area?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteButton">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let areaIdToDelete = null;

            // Function to show the delete confirmation modal
            function confirmDelete(aid) {
                areaIdToDelete = aid;
                $('#confirmDeleteModal').modal('show');
            }

            // Handle delete confirmation click
            $('#confirmDeleteButton').click(function() {
                if (areaIdToDelete !== null) {
                    $.ajax({
                        url: 'DeleteAreaById',
                        type: 'GET',
                        data: { aid: areaIdToDelete },
                        success: function(response) {
                            // Remove the deleted row without refreshing the page
                            $('#area-' + areaIdToDelete).remove();
                            $('#confirmDeleteModal').modal('hide');
                        },
                        error: function(xhr, status, error) {
                            alert("Error: Unable to delete area.");
                        }
                    });
                }
            });

            // Initialize DataTable for pagination, search, and ordering
            $(document).ready(function() {
                $('#cityTable').DataTable({
                    "paging": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "lengthChange": true,
                    "autoWidth": false
                });
            });
        </script>
    </div>

    <!-- Bootstrap JS for Modal functionality -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
</body>
</html>
