﻿var CreateImpactController = function ($scope, $document, $http, $compile, $location) {
    $scope.title = $document[0].title;
    $scope.windowTitle = angular.element(window.document)[0].title;

    $scope.getType = function (x) {
        return typeof x;
    };
    $scope.isDate = function (x) {
        return x instanceof Date;
    };

    $document.ready(function () {

        var startYearPicker = angular.element(document.querySelector('#startyearpicker'));
        var endYearPicker = angular.element(document.querySelector('#endyearpicker'));
        var selectedBeneficiaryGroups = angular.element(document.querySelector('#selectedBeneficiaryGroups'));


        $scope.selectedBeneficiaryGroup = null;
        $scope.beneficiaryGroupToRemove = null;
        $scope.beneficiaryGroups = [];
        $scope.selectedBeneficiaryGroups = [];
        $scope.impactViewModel = [];
        $scope.selectedBeneficiaryGroupSource = new kendo.data.DataSource({});
        $scope.selectedBeneficiaryGroupsTemplate = $("#selectedBeneficiaryGroupsTemplate").html();


        var dataAquisitionUrl;
        var currentURL = $location.absUrl();
        var params;
        if (currentURL.indexOf("Create") != -1) {
            dataAquisitionUrl = '/Impacts/GetBlankImpactViewModel/';
        }

        if (currentURL.indexOf("Edit") != -1) {
            dataAquisitionUrl = '/Impacts/GetExistingImpactViewModel/';
            var urlSegments = currentURL.split("/");
            var segmentCount = urlSegments.length;
            var guid = urlSegments[segmentCount - 1];
            params = {
                impactId: guid
            }
        }


        $http({
            method: 'GET',
            url: dataAquisitionUrl,
            params: params
        }).success(function (result) {
            var parsedData = JSON.parse(result);
            $scope.impactViewModel = parsedData;

            $scope.selectedBeneficiaryGroupSource = new kendo.data.DataSource({
                data: $scope.impactViewModel.SelectedBeneficiaryGroups,
                pageSize: 21
            });


            kendo.bind($("startyearpicker"), $scope.impactViewModel);

            startYearPicker.kendoDatePicker({
                change: function() {
                    var value = this.value();
                    $scope.impactViewModel.StartDate = value;
                    console.log(value); //value is the selected date in the datepicker
                },
                animation: {
                    close: {
                        effects: "fadeOut",
                        duration: 300
                    },
                    open: {
                        effects: "fadeIn zoom:in",
                        duration: 300
                    }
                },
                start: "decade",
                depth: "decade",
                format: "yyyy",
                value: $scope.impactViewModel.StartDate,
                //min: $scope.impactViewModel.StartDate,
            });

            endYearPicker.kendoDatePicker({
                change: function () {
                    var value = this.value();
                    $scope.impactViewModel.FinishDate = value;
                    console.log(value); //value is the selected date in the datepicker
                },
                animation: {
                    close: {
                        effects: "fadeOut",
                        duration: 300
                    },
                    open: {
                        effects: "fadeIn zoom:in",
                        duration: 300
                    }
                },
                start: "decade",
                depth: "decade",
                format: "yyyy",
                value: $scope.impactViewModel.FinishDate,
                min: $scope.impactViewModel.StartDate,
            });

        });


        $scope.addBeneficiaryGroup = function (selectedBeneficiaryGroup) {
            if (selectedBeneficiaryGroup != null) {
                $scope.impactViewModel.SelectedBeneficiaryGroups.push(selectedBeneficiaryGroup)
                var indexOfMatchingObject = $.inArray(selectedBeneficiaryGroup, $scope.impactViewModel.BeneficiaryGroups)
                if (indexOfMatchingObject != -1) {
                    $scope.impactViewModel.BeneficiaryGroups.splice(indexOfMatchingObject, 1);

                }

            };

            $scope.selectedBeneficiaryGroupSource = new kendo.data.DataSource({
                data: $scope.impactViewModel.SelectedBeneficiaryGroups,
                pageSize: 21,
                selectable: "multiple",
            });

        };

        $scope.removeBeneficiaryGroup = function ($event) {
            var targetId = $event.target.id;
            var selectedBeneficiaryGroupId = $event.target.value;
            var selectedBeneficiaryGroup = null;
            var targetIdParent = $event.target.parentElement;

            targetIdParent.remove();

            var indexOfMatchingObject = indexOfId($scope.impactViewModel.SelectedBeneficiaryGroups, selectedBeneficiaryGroupId);
            let index = $scope.impactViewModel.SelectedBeneficiaryGroups.map((el) => el.BeneficiaryGroupId).indexOf(selectedBeneficiaryGroupId)

            if (indexOfMatchingObject != -1) {
                selectedBeneficiaryGroup = $scope.impactViewModel.SelectedBeneficiaryGroups[indexOfMatchingObject];
                $scope.impactViewModel.SelectedBeneficiaryGroups.splice(indexOfMatchingObject, 1);
                $scope.impactViewModel.BeneficiaryGroups.push(selectedBeneficiaryGroup)
            }
        };


        function indexOfId(array, id) {
            for (var i = 0; i < array.length; i++) {
                if (array[i].BeneficiaryGroupId == id) return i;
            }
            return -1;
        }

        function onChangeAngular() {
            var data = $scope.selectedBeneficiaryGroupSource.view(),
                selected = $.map(this.select(), function (item) {
                    return data[$(item).index()].BeneficiaryGroupDescription;
                });

            console.log("Selected: " + selected.length + " item(s), [" + selected.join(", ") + "]");
        }

        $scope.postViewModelToServer = function postJsonData() {

                var updatedData = JSON.stringify($scope.impactViewModel);

                $.ajax({
                    dataType: 'json', // expected format for response
                    contentType: 'application/json; charset=utf-8', // send as JSON
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('content-type', 'application/json');
                    },
                    type: 'POST',
                    url: '/Impacts/CreateUpdateImpactWithPostedJson/',
                    data: updatedData
                })
                    .done(function (data) {
                        console.log("Response " + JSON.stringify(data));
                    })
                .success(function (result) {
                    console.log("Response " + JSON.stringify(result));
                    new PNotify({
                        title: 'Impact Details Saved',
                        text: 'The impact record was updated!',
                        type: 'success',
                        animate_speed: 'fast'
                    });
                })
                .error(function (request, textStatus, errorThrown) {
                    console.log('textStatus ' + textStatus);
                    console.log('errorThrown ' + errorThrown);
                    new PNotify({
                        title: 'Impact Details Not Saved',
                        text: 'There appears to have been an error. Please try again later.',
                        type: 'error',
                        animate_speed: 'fast'
                    });
                });



        }

    }

    )
}



CreateImpactController.$inject = ['$scope', '$document', '$http', '$compile', '$location'];
