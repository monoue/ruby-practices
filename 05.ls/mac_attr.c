#include <sys/xattr.h>
#include <sys/acl.h>
#include <ruby.h>

VALUE cMac;

VALUE attr_func(VALUE self, VALUE s_val)
{
  char *filename = StringValuePtr(s_val);

    acl_t acl = NULL;
    acl_entry_t dummy;
    ssize_t xattr = 0;
    char str[2];

    acl = acl_get_link_np(filename, ACL_TYPE_EXTENDED);
    if (acl && acl_get_entry(acl, ACL_FIRST_ENTRY, &dummy) == -1) {
        acl_free(acl);
        acl = NULL;
    }
    xattr = listxattr(filename, NULL, 0, XATTR_NOFOLLOW);
    if (xattr < 0)
        xattr = 0;

    str[1] = '\0';
    if (xattr > 0)
        str[0] = '@';
    else if (acl != NULL)
        str[0] = '+';
    else
        str[0] = ' ';
  return rb_str_new2(str);
}

void Init_mac()
{
  cMac = rb_define_class("Mac", rb_cObject);
  rb_define_method(cMac, "attr", RUBY_METHOD_FUNC(attr_func), 1);
}

