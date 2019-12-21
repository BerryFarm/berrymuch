
// DO NOT EDIT THIS FILE - it is machine generated -*- c++ -*-

#ifndef __gnu_java_security_x509_X500DistinguishedName__
#define __gnu_java_security_x509_X500DistinguishedName__

#pragma interface

#include <java/lang/Object.h>
#include <gcj/array.h>

extern "Java"
{
  namespace gnu
  {
    namespace java
    {
      namespace security
      {
          class OID;
        namespace der
        {
            class DERReader;
        }
        namespace x509
        {
            class X500DistinguishedName;
        }
      }
    }
  }
}

class gnu::java::security::x509::X500DistinguishedName : public ::java::lang::Object
{

public:
  X500DistinguishedName();
  X500DistinguishedName(::java::lang::String *);
  X500DistinguishedName(JArray< jbyte > *);
  X500DistinguishedName(::java::io::InputStream *);
  virtual ::java::lang::String * getName();
  virtual void newRelativeDistinguishedName();
  virtual jint size();
  virtual jint countComponents();
  virtual jboolean containsComponent(::gnu::java::security::OID *, ::java::lang::String *);
  virtual ::java::lang::String * getComponent(::gnu::java::security::OID *);
  virtual ::java::lang::String * getComponent(::gnu::java::security::OID *, jint);
  virtual void putComponent(::gnu::java::security::OID *, ::java::lang::String *);
  virtual void putComponent(::java::lang::String *, ::java::lang::String *);
  virtual void setUnmodifiable();
  virtual jint hashCode();
  virtual jboolean equals(::java::lang::Object *);
  virtual ::java::lang::String * toString();
  virtual JArray< jbyte > * getDer();
private:
  void parseString(::java::lang::String *);
  ::java::lang::String * readAttributeType(::java::io::Reader *);
  ::java::lang::String * readAttributeValue(::java::io::Reader *);
  void parseDer(::gnu::java::security::der::DERReader *);
  static ::java::lang::String * compressWS(::java::lang::String *);
public:
  static ::gnu::java::security::OID * CN;
  static ::gnu::java::security::OID * C;
  static ::gnu::java::security::OID * L;
  static ::gnu::java::security::OID * ST;
  static ::gnu::java::security::OID * STREET;
  static ::gnu::java::security::OID * O;
  static ::gnu::java::security::OID * OU;
  static ::gnu::java::security::OID * T;
  static ::gnu::java::security::OID * DNQ;
  static ::gnu::java::security::OID * NAME;
  static ::gnu::java::security::OID * GIVENNAME;
  static ::gnu::java::security::OID * INITIALS;
  static ::gnu::java::security::OID * GENERATION;
  static ::gnu::java::security::OID * EMAIL;
  static ::gnu::java::security::OID * DC;
  static ::gnu::java::security::OID * UID;
private:
  ::java::util::List * __attribute__((aligned(__alignof__( ::java::lang::Object)))) components;
  ::java::util::Map * currentRdn;
  jboolean fixed;
  ::java::lang::String * stringRep;
  JArray< jbyte > * encoded;
  jint sep;
public:
  static ::java::lang::Class class$;
};

#endif // __gnu_java_security_x509_X500DistinguishedName__