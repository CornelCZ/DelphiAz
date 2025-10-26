// this file contains directives that 
// has to be included into *.pas file
// in order to generate correct *.hpp files
// when using WbemScripting_TLB library.  

typedef IEnumVARIANT*  _di_IEnumVariant;

namespace Wbemscripting_tlb 
{
typedef ISWbemObject*  _di_ISWbemObject;
typedef ISWbemServices* _di_ISWbemServices;
typedef ISWbemMethod* _di_ISWbemMethod;
typedef ISWbemProperty* _di_ISWbemProperty;
typedef ISWbemPropertySet* _di_ISWbemPropertySet;
typedef ISWbemNamedValueSet* _di_ISWbemNamedValueSet;
typedef ISWbemEventSource* _di_ISWbemEventSource;
typedef ISWbemQualifier* _di_ISWbemQualifier;
typedef ISWbemQualifierSet* _di_ISWbemQualifierSet;
}
