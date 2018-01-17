
NAME
    New-UnifiedGroup
    
SYNOPSIS
    This cmdlet is available only in the cloud-based service.
    
    Use the New-UnifiedGroup cmdlet to create Office 365 groups in your 
    cloud-based organization. To add members, owners, and subscribers to 
    Office 365 groups, use the Add-UnifiedGroupLinks cmdlet.
    
    For information about the parameter sets in the Syntax section below, 
    see Exchange cmdlet syntax.
    
    
SYNTAX
    New-UnifiedGroup [-AccessType <Public | Private>] [-Alias <String>] 
    [-AlwaysSubscribeMembersToCalendarEvents <SwitchParameter>] 
    [-AutoSubscribeNewMembers <SwitchParameter>] [-Classification <String>] 
    [-DisplayName <String>] [-EmailAddresses <ProxyAddressCollection>] 
    [-ExecutingUser <RecipientIdParameter>] [-ExoErrorAsWarning 
    <SwitchParameter>] [-HiddenGroupMembershipEnabled <SwitchParameter>] 
    [-Language <CultureInfo>] [-MailboxRegion <String>] [-ManagedBy 
    <RecipientIdParameter[]>] [-Members <RecipientIdParameter[]>] [-Name 
    <String>] [-Notes <String>] [-Owner <RecipientIdParameter>] 
    [-PrimarySmtpAddress <SmtpAddress>] 
    [-RequireSenderAuthenticationEnabled <$true | $false>] 
    [-SuppressWarmupMessage <SwitchParameter>] [-Confirm <SwitchParameter>] 
    [-WhatIf <SwitchParameter>] [<CommonParameters>]
    
    New-UnifiedGroup [-AccessType <Public | Private>] [-Alias <String>] 
    [-AlwaysSubscribeMembersToCalendarEvents <SwitchParameter>] 
    [-AutoSubscribeNewMembers <SwitchParameter>] [-Classification <String>] 
    [-DisplayName <String>] [-EmailAddresses <ProxyAddressCollection>] 
    [-ExecutingUser <RecipientIdParameter>] [-ExoErrorAsWarning 
    <SwitchParameter>] [-HiddenGroupMembershipEnabled <SwitchParameter>] 
    [-Language <CultureInfo>] [-ManagedBy <RecipientIdParameter[]>] 
    [-Members <RecipientIdParameter[]>] [-Name <String>] [-Notes <String>] 
    [-Owner <RecipientIdParameter>] [-PrimarySmtpAddress <SmtpAddress>] 
    [-RequireSenderAuthenticationEnabled <$true | $false>] 
    [-SuppressWarmupMessage <SwitchParameter>] [-Confirm <SwitchParameter>] 
    [-WhatIf <SwitchParameter>] [<CommonParameters>]
    
    New-UnifiedGroup [-AccessType <Public | Private>] [-Alias <String>] 
    [-AlwaysSubscribeMembersToCalendarEvents <SwitchParameter>] 
    [-AutoSubscribeNewMembers <SwitchParameter>] [-Classification <String>] 
    [-DisplayName <String>] [-EmailAddresses <ProxyAddressCollection>] 
    [-ExecutingUser <RecipientIdParameter>] [-ExoErrorAsWarning 
    <SwitchParameter>] [-HiddenGroupMembershipEnabled <SwitchParameter>] 
    [-Language <CultureInfo>] [-ManagedBy <RecipientIdParameter[]>] 
    [-Members <RecipientIdParameter[]>] [-Name <String>] [-Notes <String>] 
    [-Owner <RecipientIdParameter>] [-PrimarySmtpAddress <SmtpAddress>] 
    [-RequireSenderAuthenticationEnabled <$true | $false>] 
    [-SubscriptionEnabled <SwitchParameter>] [-SuppressWarmupMessage 
    <SwitchParameter>] [-Confirm <SwitchParameter>] [-WhatIf 
    <SwitchParameter>] [<CommonParameters>]
    
    New-UnifiedGroup -DlIdentity <DistributionGroupIdParameter> 
    [-ConvertClosedDlToPrivateGroup <SwitchParameter>] 
    [-DeleteDlAfterMigration <SwitchParameter>] [-ExecutingUser 
    <RecipientIdParameter>] [-Owner <RecipientIdParameter>] [-Confirm 
    <SwitchParameter>] [-ManagedBy <MultiValuedProperty>] [-Members 
    <MultiValuedProperty>] [-WhatIf <SwitchParameter>] [<CommonParameters>]
    
    
DESCRIPTION
    Office 365 groups are group objects that are available across Office 
    365 services.
    
    You need to be assigned permissions before you can run this cmdlet. 
    Although this topic lists all parameters for the cmdlet, you may not 
    have access to some parameters if they're not included in the 
    permissions assigned to you. To find the permissions required to run 
    any cmdlet or parameter in your organization, see Find the permissions 
    required to run any Exchange cmdlet.
    

PARAMETERS
    -DlIdentity <DistributionGroupIdParameter>
        The DlIdentity parameter specifies the distribution group (also 
        known as a distribution list or DL) that you want to migrate to an 
        Office 365 Group. The distribution group must be a universal 
        distribution group (the RecipientTypeDetails property value is 
        MailUniversalDistributionGroup). You can use any value that 
        uniquely identifies the distribution group.
        
        For example:
        
        * Name
        * Display name
        * Alias
        * Distinguished name (DN)
        * Canonical DN
        * Email address
        * GUID
        All the properties and membership of the distribution group are 
        copied to the Office 365 Group.
        
        The alias and proxy addresses of the distribution group are moved 
        to the Office 365 Group, and are replaced on the distribution group 
        by the values DLMigrated_<GUID>. The original proxy addresses are 
        copied to the ExtensionCustomAttribute5 attribute of the 
        distribution group.
        
        Office 365 groups don't have ReportToManager and ReportToOriginator 
        parameters, so the values of these parameters aren't migrated from 
        the distribution group to the Office 365 Group. The Office 365 
        Group behaves as if the default values of these parameters were set 
        (ReportToManager is $false and ReportToOriginator is $true). In 
        other words, delivery status notifications (also known as DSNs, 
        non-delivery reports, NDRs, or bounce messages) are sent to the 
        message sender and not to the owner of the Office 365 Group.
        
        Required?                    true
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -AccessType <Public | Private>
        The AccessType parameter specifies the privacy type for the Office 
        365 Group. Valid values are:
        
        * Public The group content and conversations are available to 
          everyone, and anyone can join the group without approval from a 
          group owner. This is the default value.
        * Private The group content and conversations are only available to 
          members of the group, and joining the group requires approval 
          from a group owner.
        You can change the privacy type at any point in the lifecycle of 
        the group.
        
        Note: Although a user needs to be a member to participate in a 
        private group, anyone can send email to a private group, and 
        receive replies from the private group.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Alias <String>
        The Alias parameter specifies the Exchange alias (also known as the 
        mail nickname) for the Office 365 Group. This value identifies the 
        recipient as a mail-enabled object, and shouldn't be confused with 
        multiple email addresses for the same recipient (also known as 
        proxy addresses). A recipient can have only one Alias value.
        
        The value of Alias can contain letters, numbers and the characters 
        !, #, $, %, &, ', *, +, -, /, =, ?, ^, _, `, {, |, } and ~. Periods 
        (.) are allowed, but each period must be surrounded by other valid 
        characters (for example, help.desk). Unicode characters from U+00A1 
        to U+00FF are also allowed. The maximum length of the Alias value 
        is 64 characters.
        
        When you create an Office 365 Group without using the 
        EmailAddresses parameter, the Alias value you specify is used to 
        generate the primary email address (<alias>@<domain>). Supported 
        Unicode characters are mapped to best-fit US-ASCII text characters. 
        For example, U+00F6 (ö) is changed to oe in the primary email 
        address.
        
        If you don't use the Alias parameter when you create an Office 365 
        Group, the value of the DisplayName parameter is used. Spaces are 
        removed, unsupported characters are converted to question marks 
        (?), and numbers may be added to maintain the uniqueness of the 
        Alias value.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -AlwaysSubscribeMembersToCalendarEvents <SwitchParameter>
        The AlwaysSubscribeMembersToCalendarEvents switch controls the 
        default subscription settings of new members that are added to the 
        Office 365 Group.
        
        * If you use this switch without a value, all future members that 
          are added to the group will have their subscriptions set to 
          ReplyAndEvents.
        * If you use this exact syntax: 
          -AlwaysSubscribeMembersToCalendarEvents:$false, all future 
          members that are added to the group will have their subscriptions 
          set to ReplyOnly.
        Group members can change their own subscription settings, which can 
        override your intended use of this switch.
        
        The AutoSubscribeNewMembers switch overrides this switch.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -AutoSubscribeNewMembers <SwitchParameter>
        The AutoSubscribeNewMembers switch specifies whether to 
        automatically subscribe new members that are added to the Office 
        365 Groupto conversations and calendar events. You don't need to 
        specify a value with this switch.
        
        You need to use this switch with the SubscriptionEnabled switch.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Classification <String>
        This parameter is reserved for internal Microsoft use.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Confirm [<SwitchParameter>]
        The Confirm switch specifies whether to show or hide the 
        confirmation prompt. How this switch affects the cmdlet depends on 
        if the cmdlet requires confirmation before proceeding.
        * Destructive cmdlets (for example, Remove-* cmdlets) have a 
          built-in pause that forces you to acknowledge the command before 
          proceeding. For these cmdlets, you can skip the confirmation 
          prompt by using this exact syntax: -Confirm:$false.
        * Most other cmdlets (for example, New-* and Set-* cmdlets) don't 
          have a built-in pause. For these cmdlets, specifying the Confirm 
          switch without a value introduces a pause that forces you 
          acknowledge the command before proceeding.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -ConvertClosedDlToPrivateGroup <SwitchParameter>
        The ConvertClosedDlToPrivateGroup switch specifies whether to 
        migrate the closed distribution group to a private Office 365 
        Group. You don't need to specify a value with this switch.
        
        By default, this switch is always applied when migrating closed 
        distribution groups, and will eventually be deprecated.
        
        If the distribution group has the value Closed for the 
        MemberDepartRestriction or MemberJoinRestriction parameters, the 
        distribution group will always be migrated to a private Office 365 
        Group. For open distribution groups, the migrated Office 365 Group 
        is always public, not private.
        
        You can only use this switch with the DlIdentity parameter.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -DeleteDlAfterMigration <SwitchParameter>
        The DeleteDlAfterMigration switch specifies whether to delete the 
        distribution group after it's migrated to an Office 365 Group. You 
        don't need to specify a value with this switch.
        
        You can only use this switch with the DlIdentity parameter.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -DisplayName <String>
        The DisplayName parameter specifies the name of the Office 365 
        Group. The display name is visible in the Exchange admin center, 
        address lists, and Outlook. The maximum length is 256 characters. 
        If the value contains spaces, enclose the value in quotation marks 
        (").
        
        For Office 365 groups, the DisplayName value is used in the unique 
        Name property. However, because the DisplayName value doesn't need 
        to be unique, the DisplayName value is appended with an underscore 
        character (_) and a short GUID value when it's used for the Name 
        property.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -EmailAddresses <ProxyAddressCollection>
        The EmailAddresses parameter specifies all the email addresses 
        (proxy addresses) for the recipient, including the primary SMTP 
        address. In on-premises Exchange organizations, the primary SMTP 
        address and other proxy addresses are typically set by email 
        address policies. However, you can use this parameter to configure 
        other proxy addresses for the recipient. For more information, see 
        Email address policies in Exchange 2016.
        
        Valid syntax for this parameter is 
        <Type>:<emailaddress1>,<Type>:<emailaddress2>.... The optional 
        <Type> value specifies the type of email address. Some examples of 
        valid values include:
        
        * SMTP The primary SMTP address. You can use this value only once 
          in a command.
        * smtp Other SMTP email addresses.
        * X400 X.400 addresses in on-premises Exchange.
        * X500 X.500 addresses in on-premises Exchange.
        If you don't include a <Type> value for an email address, the value 
        smtp is assumed. Note that Exchange doesn't validate the syntax of 
        custom address types (including X.400 addresses). Therefore, you 
        need to verify that any custom addresses are formatted correctly.
        
        To specify the primary SMTP email address, you can use any of the 
        following methods:
        
        * Use the <Type> value SMTP on the address.
        * The first email address when you don't use any <Type> values, or 
          when you use multiple <Type> values of smtp.
        * If it's available, use the PrimarySmtpAddress parameter instead. 
          You can't use the EmailAddresses parameter and the 
          PrimarySmtpAddress parameter in the same command.
        To replace all existing proxy email addresses with the values you 
        specify, use the following syntax: 
        "<Type>:<emailaddress1>","<Type>:<emailaddress2>"....
        
        To add or remove specify proxy addresses without affecting other 
        existing values, use the following syntax: 
        @{Add="<Type>:<emailaddress1>","<Type>:<emailaddress2>"...; 
        Remove="<Type>:<emailaddress2>","<Type>:<emailaddress2>"...}.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -ExecutingUser <RecipientIdParameter>
        This parameter is reserved for internal Microsoft use.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -ExoErrorAsWarning <SwitchParameter>
        The ExoErrorAsWarning switch specifies that Exchange Online errors 
        that you encounter while creating the Office 365 Group are treated 
        as warnings, not errors. You don't need to specify a value with 
        this switch.
        
        Creating Office 365 groups involves background operations in Azure 
        Active Directory and Exchange Online. Errors that you might 
        encounter in Exchange Online don't prevent the creation of the 
        group (and therefore aren't really errors), because the group 
        object in Azure Active Directory is synchronized back to Exchange 
        Online.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -HiddenGroupMembershipEnabled <SwitchParameter>
        The HiddenGroupMembershipEnabled switch specifies whether to hide 
        the members of the Office 365 Group from users who aren't members 
        of the group. You don't need to specify a value with this switch.
        
        You can use this setting to help comply with regulations that 
        require you to hide group membership from outsiders (for example, 
        an Office 365 Group group that represents students enrolled in a 
        class).
        
        Note: You can't change this setting after you create the group. If 
        you create the group with hidden membership, you can't edit the 
        group later to reveal the membership to the group.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Language <CultureInfo>
        The Language parameter specifies the language preference for the 
        Office 365 Group.
        
        Valid input for this parameter is a supported culture code value 
        from the Microsoft .NET Framework CultureInfo class. For example, 
        da-DK for Danish or ja-JP for Japanese. For more information, see 
        CultureInfo Class 
        (https://go.microsoft.com/fwlink/p/?linkId=184859).
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -MailboxRegion <String>
        PARAMVALUE: String
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -ManagedBy <RecipientIdParameter[]>
        This parameter is reserved for internal Microsoft use.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Members <RecipientIdParameter[]>
        The Members parameter specifies the recipients (mail-enabled 
        objects) that are members of the Office 365 Group. You can use any 
        value that uniquely identifies the recipient.
        
        For example:
        
        * Name
        * Display name
        * Alias
        * Distinguished name (DN)
        * Canonical DN
        * Email address
        * GUID
        To enter multiple values, use the following syntax: 
        <value1>,<value2>,...<valueX>. If the values contain spaces or 
        otherwise require quotation marks, use the following syntax: 
        "<value1>","<value2>",..."<valueX>".
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Name <String>
        The Name parameter specifies the name of the Office 365 Group. The 
        maximum length is 64 characters. If the value contains spaces, 
        enclose the value in quotation marks (").
        
        The value that you use for this is parameter is appended with an 
        underscore character (_) and a short GUID value.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Notes <String>
        The Notes parameter specifies the description of the Office 365 
        Group. If the value contains spaces, enclose the value in quotation 
        marks.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -Owner <RecipientIdParameter>
        The Owner parameter specifies one or more owners for the Office 365 
        Group. Owners are group members who have certain privileges, such 
        as the ability to edit group properties.
        
        The owner you specify for this parameter must be a mailbox or mail 
        user (a mail-enabled security principal that can have permissions 
        assigned). You can use any value that uniquely identifies the 
        owner. For example:
        
        For example:
        
        * Name
        * Display name
        * Alias
        * Distinguished name (DN)
        * Canonical DN
        * <domain name>\<account name>
        * Email address
        * GUID
        * LegacyExchangeDN
        * SamAccountName
        * User ID or user principal name (UPN)
        You can specify multiple owners separated by commas
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -PrimarySmtpAddress <SmtpAddress>
        The PrimarySmtpAddress parameter specifies the primary return email 
        address that's used for the recipient. If it's available on this 
        cmdlet, you can't use the EmailAddresses and PrimarySmtpAddress 
        parameters in the same command.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -RequireSenderAuthenticationEnabled <$true | $false>
        The RequireSenderAuthenticationEnabled parameter specifies whether 
        to accept messages only from authenticated (internal) senders. 
        Valid values are:
        * $true Messages are accepted only from authenticated (internal) 
          senders. Messages from unauthenticated (external) senders are 
          rejected.
        * $false Messages are accepted from authenticated (internal) and 
          unauthenticated (external) senders.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -SubscriptionEnabled <SwitchParameter>
        The SubscriptionEnabled switch specifies whether subscriptions to 
        conversations and calendar events are enabled for the Office 365 
        Group. You don't need to specify a value with this switch.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -SuppressWarmupMessage <SwitchParameter>
        This parameter has been deprecated and is no longer used.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    -WhatIf [<SwitchParameter>]
        The WhatIf switch simulates the actions of the command. You can use 
        this switch to view the changes that would occur without actually 
        applying those changes. You don't need to specify a value with this 
        switch.
        
        Required?                    false
        Position?                    Named
        Default value                
        Accept pipeline input?       False
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, 
    see 
        about_CommonParameters 
    (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
        To see the input types that this cmdlet accepts, see Cmdlet Input 
        and Output Types (http://go.microsoft.com/fwlink/p/?linkId=616387). 
        If the Input Type field for a cmdlet is blank, the cmdlet doesn't 
        accept input data.
    
    
OUTPUTS
    
        To see the return types, which are also known as output types, that 
        this cmdlet accepts, see Cmdlet Input and Output Types 
        (http://go.microsoft.com/fwlink/p/?linkId=616387). If the Output 
        Type field is blank, the cmdlet doesn't return data.
    
    
    -------------------------- Example 1 --------------------------
    
    
    
    This example creates a new Office 365 Group named Engineering 
    Department.
    
    
    New-UnifiedGroup -DisplayName "Engineering Department" -Alias 
    engineering
    
    
RELATED LINKS
    Online Version http://technet.microsoft.com/EN-US/library/187acc17-10de-
    4f38-8efc-7c95d2b3df00(EXCHG.160).aspx




