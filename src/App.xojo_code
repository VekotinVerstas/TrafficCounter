#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  WriteLog ("Starting Traffic Counter for Raspberry Pi 3",ErrorLevel.NORMAL)
		  WriteLog ("Version "+str(app.MajorVersion)+"."+str(app.MinorVersion)+"."+str(app.BugVersion),ErrorLevel.NORMAL)
		  
		  // do
		  // 
		  // loop until App.LDC1614_init
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub DelayMilliseconds(duration As UInteger)
		  #If TargetARM And TargetLinux Then
		    Soft Declare Sub wpDelay Lib "libwiringPi.so" Alias "delay" (duration As UInteger)
		    wpDelay(duration)
		  #Endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetChipID(fd as Integer) As Integer
		  return ReadReg8(fd,REG_CHIPID) // &h55 should be expected here. (85 dec)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LDC1614_init() As Boolean
		  // based on example by Einhugur for BMP180 barometer
		  
		  #if TargetARM and TargetLinux then
		    
		    dim fd as Int32
		    dim mb as New MemoryBlock(2)
		    
		  #endif
		  
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintLCD(row as Integer, msg as Text)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub WriteLog(msg as String, severity as ErrorLevel)
		  print msg
		  
		  dim f as FolderItem
		  dim t as TextOutputStream
		  dim d as new date
		  dim s as string
		  
		  s = "["+d.SQLDateTime+"] "
		  
		  f = SpecialFolder.VarLog
		  
		  if f<>nil then
		    
		    try
		      SELECT CASE severity
		        
		      CASE ErrorLevel.NORMAL
		        f = f.child("TrafficCounterPi_NORMAL.log")
		      CASE ErrorLevel.DEBUG
		        f = f.child("TrafficCounterPi_DEBUG.log")
		      CASE ErrorLevel.WARNING
		        f = f.child("TrafficCounterPi_WARNING.log")
		      CASE ErrorLevel.CRITICAL
		        f = f.child("TrafficCounterPi_CRITICAL.log")
		      ELSE
		        f = f.child("TrafficCounterPi.log")
		      END SELECT
		      
		      if f.exists and f.IsWriteable then
		        
		        t = TextOutputStream.append(f)
		        
		        if t<>nil then
		          t.writeline s + msg
		        end
		        
		      else
		        
		        t = TextOutputStream.Create(f)
		        
		        if t<>nil then
		          t.writeline msg
		        end
		        
		      end
		      
		      if t<>nil then t.Close
		      
		    catch err as IOException
		      
		      print "ERROR: Got IOException in WriteLog"
		      
		    end try
		    
		  end
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = REG_CHIPID, Type = Double, Dynamic = False, Default = \"&hD0", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ErrorLevel, Type = Integer, Flags = &h0
		DEBUG
		  NORMAL
		  WARNING
		CRITICAL
	#tag EndEnum

	#tag Enum, Name = Mode, Flags = &h1
		ULTRALOWPOWER=0
		  STANDARD=1
		  HIGHRES =2
		ULTRAHIGHRES = 3
	#tag EndEnum


End Class
#tag EndClass
