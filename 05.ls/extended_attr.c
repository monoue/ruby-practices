#include <sys/xattr.h>
#include <sys/acl.h>
#include <stdio.h>

int main (void) {
    acl_t acl = NULL;
    acl_entry_t dummy;
    ssize_t xattr = 0;
    char str[10];
    char * filename = "/System";

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

    printf("%s\n", str);
}
