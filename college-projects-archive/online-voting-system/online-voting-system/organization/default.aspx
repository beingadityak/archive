<%@ Page Title="" Language="C#" MasterPageFile="~/organization/organization.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="online_voting_system.organization._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Political Parties/Organizations</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br>
    <div class="container-fluid">
              <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>
                  <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">

                  <div class="item active">
                    <center><img src="/images/party1.jpg" alt="Party 1" width="740" height="493"></center>
                  </div>

                  <div class="item">
                    <center><img src="/images/party2.png" alt="Party 2" width="740" height="493"></center>
                  </div>

                    <div class="item">
                    <center><img src="/images/party4.jpg" alt="Party 4" width="740" height="493"></center>
                  </div>
  
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                  <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
                <br/>
                <div class="jumbotron">
                            <h1>Political Parties</h1>
                            <p>In this section, the Political Parties/Organizations can register themselves for the Online Voting System</p>
                        </div>
    </div>
</asp:Content>
