// Where did the other functions go?

function onScriptLoad() {

   FileRead("file.txt")
   //ReadIni("file.txt", "John", "Money")
}


local myfiles = null;
local ini_struct = ["filename", "section", "output", "val"]

function FileRead(filename) {
    
  // It's not wise to always acess this function 
  
  myfiles = file(filename, "r");
  filedata = "";
  try {
    while (true) {
      foreach(value in myfiles.readn('b').tochar()) {    
        filedata += value.tochar().tostring();
      }
    }
  } 
  catch(e) { 

  }
}
  

// Need to check data n shit before writting. Right area. Does it exist etc
function WriteIni(filename, section, key, value) {

  // Removed text wrap and implimented a basic edit
  ini_struct[0] = filename; // The name of the file we use
  ini_struct[1]= "["+section+"]\n" // The section that's used 
  ini_struct[2]= key+" = "; // 
  ini_struct[3]= value+"\n";
    
  // The file we are writing to 
  myfiles = file(ini_struct[0], "a+");

  // Else resume
  local i = 1;
  try {
    while (i != 3) {
      foreach(value in ini_struct[i]) {    
        myfiles.writen(value, 'b');
          
        // Add what was written to the data string [Impliment a array or table instead]
        filedata += value.tochar().tostring();
      }
      i++;
    }
  } 
  catch(e) { print(e); }

  myfiles.writen('\n', 'b');
  myfiles.flush();
  myfiles.close();
}





















