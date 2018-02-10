function getModelData(word, modelType, model) {

    var xmlhttp = new XMLHttpRequest();
    var url;
    if (modelType === "translation") {
        url = "https://glosbe.com/gapi/translate?from=spa&dest=eng&format=json&phrase="+ word;
    }
    else {
        url = "https://glosbe.com/gapi/tm?from=spa&dest=eng&format=json&page=1&phrase="+ word;
    }


    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE && xmlhttp.status == 200) {
            if (modelType === "translation") {
                setTranslations(xmlhttp.responseText, model);
            }
            else {
                setExamples(xmlhttp.responseText, model);
            }


        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

function setTranslations(response, model) {
    var arr = [];
    var tuc = [];
    var resultArray = [];
    var phrase;
    var meaning;
    if (response) {
        arr = JSON.parse(response);
        if(arr.hasOwnProperty("result")) {
            if(arr["result"].toString() === "ok") {
                if(arr.hasOwnProperty("tuc")) {
                    tuc = arr["tuc"];
                    if (tuc.length >0) {
                        for (var i=0; i< tuc.length; i++) {
                            phrase =""; meaning = "";
                            if(tuc[i].hasOwnProperty("phrase") && tuc[i]["phrase"] && tuc[i]["phrase"]["text"] ) {
                                phrase = tuc[i]["phrase"]["text"]
                                if(tuc[i].hasOwnProperty("meanings") ) {
                                    var meanings = tuc[i]["meanings"];
                                    if (meanings.length > 0) {
                                        for (var k=0; k < meanings.length; k++) {
                                            if (meanings[k].hasOwnProperty("text")) {
                                                meaning = meanings[k]["text"] + "\n";
                                            }
                                        }
                                    }
                                }
                                model.append( {phrase_text: phrase, meaning_text : meaning});
                            }

                        }
                    }

                }

            }
        }
    }
}

function setExamples(response, model) {

    var arr = [];
    var examples = [];
    if (response) {
        arr = JSON.parse(response);
        if(arr.hasOwnProperty("result")) {
            if(arr["result"].toString() === "ok") {
                if(arr.hasOwnProperty("examples")) {
                    examples = arr["examples"];

                    if (examples.length >0) {
                        for (var i=0; i< examples.length; i++) {
                            if(examples[i].hasOwnProperty("first") && examples[i].hasOwnProperty("second")  ) {
                                model.append( {first_text: examples[i]["first"], second_text : examples[i]["second"]});
                            }
                        }
                    }
                }
            }
        }
    }
}
