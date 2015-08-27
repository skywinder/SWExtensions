//
// Created by Petr Korolev on 20/05/15.
// Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import Foundation


    func pp(object: AnyObject) -> () {
        println (PP.getRepresentation(object))
    }

public class PP {
    
    class func getRepresentation(object: AnyObject) -> (String) {
        let props = reflect(object)
        let count = props.count
        var str = PP.listProperties(props)
        
        return str
    }
    
    
    class func listProperties(mirror: MirrorType, indent:String = "") -> String
    {
        var str = ""
        for (var i=0;i<mirror.count;i++)
        {
            if (mirror[i].0 == "super") {
                
                if let repl = PP.replaceMatches("__lldb_expr_\\d*\\.", inString: mirror[i].1.summary, withString: "") {
                    str += PP.superPP(mirror[i].1, prefix:repl, indent: "\(indent)!")
                }
                else{
                    str += "ERROR"
                }
                
            }
            else if PP.containsMatch("__lldb_expr_\\d*\\.", inString: mirror[i].1.summary) {
                if let repl = PP.replaceMatches("__lldb_expr_\\d*\\.", inString: mirror[i].1.summary, withString: "") {
                    str += PP.subClassPP(mirror[i].1, prefix:repl, indent: "\(indent)>")
                    mirror[i].1.summary
                    repl
                }
            } else {
                str += "\(indent)\(representVar(mirror, index: i))"
            }
        }
        return str
    }
    
    class func superPP(mirror:MirrorType, prefix: String, indent: String = "")->String{
        return PP.subPP(mirror, prefix: "\(indent)Super: \(prefix) -> ", indent: indent)
    }
    
    class func subClassPP(mirror:MirrorType, prefix: String, indent: String = "")->String{
        return PP.subPP(mirror, prefix: "\(indent)Class: \(prefix) -> ", indent: indent)
    }
    
    class func subPP(mirror:MirrorType, prefix: String, indent: String = "")->String{
        var str = "\(prefix)\n"
        return str + listProperties(mirror, indent: indent)
    }
    
    class func representVar(mirror: MirrorType, index: Int) -> String{
        return "\(mirror[index].0) = \(mirror[index].1.summary)\n"
    }
    
    
    class func containsMatch(pattern: String, inString string: String) -> Bool {
        let regex = NSRegularExpression(pattern: pattern, options: .allZeros, error: nil)
        let range = NSMakeRange(0, count(string))
        return regex?.firstMatchInString(string, options: .allZeros, range: range) != nil
    }
    
    class func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
        let regex = NSRegularExpression(pattern: pattern, options: .allZeros, error: nil)
        let range = NSMakeRange(0, count(string))
        
        return regex?.stringByReplacingMatchesInString(string, options: .allZeros, range: range, withTemplate: replacementString)
    }
    
}

