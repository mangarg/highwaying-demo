<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default-demo.aspx.cs" Inherits="highwaying_demo.default_demo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   
<!--
    <script
src="http://maps.googleapis.com/maps/api/js">
</>

<script>
var x=new google.maps.LatLng(52.395715,4.888916);
var stavanger=new google.maps.LatLng(58.983991,5.734863);
var amsterdam=new google.maps.LatLng(52.395715,4.888916);
var london=new google.maps.LatLng(51.508742,-0.120850);

function initialize()
{
var mapProp = {
  center:x,
  zoom:4,
  mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  
var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

var myTrip=[stavanger,amsterdam,london];
var flightPath=new google.maps.Polyline({
  path:myTrip,
  strokeColor:"#0000FF",
  strokeOpacity:0.8,
  strokeWeight:2
  });

flightPath.setMap(map);

var marker = new google.maps.Marker({
    position: x,
});

marker.setMap(map);

var marker1 = new google.maps.Marker({
    position: stavanger,
});

marker1.setMap(map);

var marker2 = new google.maps.Marker({
    position: amsterdam,
});

marker2.setMap(map);


var marker3 = new google.maps.Marker({
    position: london,
});

marker3.setMap(map);


}

google.maps.event.addDomListener(window, 'load', initialize);
</script>
    
    -->
   <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
<script type="text/javascript">
var source, destination, hgText, hgValue, startpoint, endpoint;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
google.maps.event.addDomListener(window, 'load', function () {
    new google.maps.places.SearchBox(document.getElementById('txtSource'));
    new google.maps.places.SearchBox(document.getElementById('txtDestination'));
    directionsDisplay = new google.maps.DirectionsRenderer({ 'draggable': true });
});
 
function GetRoute() {
  
    var mumbai = new google.maps.LatLng(18.9750, 72.8258);
    var mapOptions = {
        zoom: 7,
        center: mumbai
    };
    map = new google.maps.Map(document.getElementById('dvMap'), mapOptions);
   
    directionsDisplay.setMap(map);

 var trafficLayer = new google.maps.TrafficLayer();
  trafficLayer.setMap(map);
    //test 

   
    directionsDisplay.setPanel(document.getElementById('dvPanel'));



    var ddlhighway = document.getElementById("<%=DropDownHighwayList.ClientID%>");
   

     hgText = ddlhighway.options[ddlhighway.selectedIndex].text;
     hgValue = ddlhighway.options[ddlhighway.selectedIndex].value;


  
    startpoint = hgValue.substring(0, hgValue.indexOf("|"));
    endpoint = hgValue.substring(hgValue.indexOf("|")+1);
 //   alert(endpoint);
 
   
    
    //*********DIRECTIONS AND ROUTE**********************//
 //   source = document.getElementById("txtSource").value;
   // destination = document.getElementById("txtDestination").value;
   
 
    source = startpoint;
    destination = endpoint;

    var request = {
        origin: source,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
    };
    directionsService.route(request, function (response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });
 

   

    //*********DISTANCE AND DURATION**********************//
    var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix({
        origins: [source],
        destinations: [destination],
        travelMode: google.maps.TravelMode.DRIVING,
        unitSystem: google.maps.UnitSystem.METRIC,
        avoidHighways: false,
        avoidTolls: false
    }, function (response, status) {
        if (status == google.maps.DistanceMatrixStatus.OK && response.rows[0].elements[0].status != "ZERO_RESULTS") {
            var distance = response.rows[0].elements[0].distance.text;
            var duration = response.rows[0].elements[0].duration.text;
            var dvDistance = document.getElementById("dvDistance");
           dvDistance.innerHTML = "";
            dvDistance.innerHTML += "Distance: " + distance + "<br />";
            dvDistance.innerHTML += "Duration:" + duration;
 
        } else {
            alert("Unable to find the distance via road.");
        }
    });

   

}
</script>

    <table style="width:100%;">
        <tr>
            <td style="width: 28px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 28px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 28px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td >
                <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" Text="Where are you driving today?"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 28px; height: 58px;">
                <asp:DropDownList ID="DropDownHighwayList" runat="server" Font-Size="XX-Large" OnSelectedIndexChanged="DropDownHighwayList_SelectedIndexChanged">
                </asp:DropDownList>
               
            </td>
            <td style="height: 58px">
                &nbsp;<input type="text" id="txtSource" value="Bandra, Mumbai, India" style="width: 200px" hidden="hidden" />
      <br /> &nbsp;<input type="text" id="txtDestination" value="Andheri, Mumbai, India" style="width: 200px" hidden="hidden" />
                <input type="button" value="Get Route" onclick="GetRoute()" hidden="hidden" />

            </td>
        </tr>
        <tr>
            <td style="width: 28px"><asp:DropDownList ID="DropDownList1" runat="server">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>

        <tr>
    <td colspan="2">
        <div id="dvDistance">
        </div>
    </td>
</tr>

        <tr>
    <td>
        <div id="dvMap" style="width: 500px; height: 500px">
        </div>
    </td>
    <td>
        <div id="dvPanel" style="width: 500px; height: 500px">
        </div>
    </td>
</tr>


    </table>
    <div id="googleMap" style="width:500px;height:380px;"></div>

  

<p>
   



</asp:Content>


